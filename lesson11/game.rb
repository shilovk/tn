# frozen_string_literal: true

require_relative 'modules/interface'
require_relative 'modules/steps'
require_relative 'user_player'
require_relative 'dealer_player'
require_relative 'deck'

# Game
class Game
  include Steps

  @bank = 0
  @sessions = []
  class << self
    attr_accessor :bank, :sessions, :deck
  end

  attr_accessor :score
  attr_reader :player

  def initialize(player)
    @player = player
    @score = 0
    Game.sessions << self
  end

  def self.play
    @deck = Deck.new
    sessions.each(&:init)

    loop { sessions.each(&:choosing) }
  rescue StandardError => e
    play if Interface.play_next?(e)
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
      winners ? win(winners, max) : no_win
      raise Interface.info_game_over
    end

    def no_win
      Interface.show_no_winners
      sessions.each do |session|
        session.player.money += 10
        self.bank -= 10
        cards = session.player.cards_names(show: true)
        Interface.show_player(sesion.player, cards: cards, score: session.score)
      end
    end

    def win(players, score)
      Interface.show_winners
      money = bank / players.count
      players.each do |player|
        player.money += money
        cards = player.cards_names(show: true)
        Interface.show_player(player, cards: cards, score: score)
      end
      self.bank = 0
    end

    def scores
      sessions.map(&:score)
    end

    def players_by_score(value)
      sessions.map do |session|
        session.player if session.score == value
      end.compact
    end

    def three_cards?
      count = sessions.inject(0) do |sum, session|
        sum += 1 if session.player.cards.count == 3
        sum
      end
      count == sessions.count
    end
  end

  def choosing(steps)
    return run_step('opening') if Game.three_cards?

    step = if player.user?
      Interface.choose_step(steps, player, cards: player.cards_names)
    else
      steps.first
    end
    steps.include?(step) ? run_step(step) : choosing
  end

  def run_step(step)
    send step unless step == 'next'
    Interface.show_player(player, cards: player.cards_names)
  end

  def taking
    Interface.show_taking(player.name)
    player.add_card(Game.deck.take_card)
    self.score = Card.calc(player.cards_points)
  end

  def opening
    Game.sessions.each do |session|
      cards = session.player.cards_names(show: true)
      Interface.show_player(session.player, cards: cards, score: session.score)
    end
    Game.analize
    false
  end
end
