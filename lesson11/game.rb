# frozen_string_literal: true

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
      p e.message
      p 'Play next? y - yes'
      play if gets.chomp == 'y'
      exit
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

  def self.analize
    max = scores.max
    max = (scores - [max]).max if max > 21
    winners = Game.players_by_score(max)
    winners ? win(winners) : no_win
    raise 'Gave Over'
  end
  
  def self.no_win
    p 'No winners'
    sessions.each do |session|
      session.player.money += 10
      self.bank -= 10
    end
  end

  def self.win(players)
    p 'Win:'
    money = bank / players.count
    players.each do |player|
      p player.name
      p player.money += money
    end
    self.bank = 0
  end

  def self.scores
    scores = sessions.map(&:score)
  end

  def self.players_by_score(value)
    sessions.map { |session| session.player if session.score == value }.compact
  end

  def choosing(steps)
    info
    p "#{player.name}, please choose the step:"
    steps.each { |step| p "#{step} - #{Game::STEPS[step]}" }
    step = gets.chomp
    return if step == '' || step == 'next'

    send step
    info
  end

  def taking
    p "#{player.name}, you are taking a card..."
    player.add_card(Card.new)
    self.score = Card.calc(player.cards_points)
    sleep(1)
  end

  def opening
    Game.sessions.each { |session| info(session, { show: true } ) }
    Game.analize
  end

  def info(session = self, *args)
    player = session.player
    p "#{player.name}, your cards:"
    p player.cards_names(args[0])
    p session.score if args[0] and args[0][:show]
    sleep(2)
  end
end
