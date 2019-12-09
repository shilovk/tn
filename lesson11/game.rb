# frozen_string_literal: true

require_relative 'modules/interface'
require_relative 'modules/game_mixin'
require_relative 'user_player'
require_relative 'dealer_player'
require_relative 'card'

# Game
class Game
  include GameMixin

  @bank = 0
  @sessions = []
  class << self
    attr_accessor :bank, :sessions
  end

  attr_accessor :score
  attr_reader :player

  def initialize(player)
    @player = player
    @score = 0
    Game.sessions << self
  end

  def self.play
    sessions.each { |session| session.init }
    loop do
      sessions.each { |session| session.choosing }
    rescue => e
      play if Interface.play_next?(e)
    end
  end

  def init
    player.cards.clear
    player.money -= 10
    Game.bank += 10
    2.times { taking }
    choosing
  end

  protected

  class << self 
    def analize
      max = scores.max
      max = (scores - [max]).max if max > 21
      winners = Game.players_by_score(max)
      winners ? win(winners) : no_win
      raise Interface.info_game_over
    end
    
    def no_win
      Interface.show_no_winners
      sessions.each do |session|
        session.player.money += 10
        self.bank -= 10
        Interface.show_players(session.player)
      end
    end

    def win(players)
      Interface.show_winners
      money = bank / players.count
      players.each do |player|
        player.money += money
      end
      Interface.show_players(players)
      self.bank = 0
    end

    def scores
      scores = sessions.map(&:score)
    end

    def players_by_score(value)
      sessions.map { |session| session.player if session.score == value }.compact
    end
  end

  def choosing(steps)
    step = Interface.choose_step(steps, player, player.cards_names)
    return if step == '' || step == 'next'
    send step
    Interface.show_players(player, player.cards_names)
  end

  def taking
    Interface.show_taking(player.name)
    player.add_card(Card.new)
    self.score = Card.calc(player.cards_points)
  end

  def opening
    Game.sessions.each do |session|
      Interface.show_players(session.player, session.player.cards_names(hide: false), session.score)
    end
    Game.analize
  end
end
