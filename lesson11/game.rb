# frozen_string_literal: true

require 'pry'
require_relative 'modules/game_mixin'
require_relative 'player'
require_relative 'card'

# Game
class Game
  include GameMixin

  @bank = 0
  class << self
    attr_accessor :bank
  end

  attr_reader :player

  def initialize(player)
    @player = player
    init
  end

  def init
    p "#{player.name}, you are taking 2 cards"
    player.money -= 10
    Game.bank += 10
    player.add_card
    player.add_card
    sleep(1)
    p 'And they are:'
    p player.cards_names
    p player.cards_values
    sleep(1)
    choosing
    sleep(1)
    p Game.bank
  end

  def choosing(steps)
    p "#{player.name}, please choose:"
    p Game::STEPS
    choose = gets.chomp
    player.add_card
    p player.cards_names
    p player.cards_values
    sleep(1)
  end

  #  def new_card
  #   raise 'You can not take over 3 cards!' if @@cards.count == 3

  #   add_card
  # end

  # def open_cards

  # end

  #   loop do
  #     [user, dealer].each do |player|
  #       choosing_for(player)
  #       raise 'You lose' if player.over
  #     end
  #   end
  # rescue => e
  #   p e.message
  #   winner
  #   again?
  # end

  # def winner
  #   if user.sum == dealer.sum
  #     @user.money += @bank / 2
  #     @dealer.money += @bank / 2
  #   elsif user.sum > dealer.sum
  #     @user.money += Main.bank
  #   else
  #     @dayler.money += Main.bank
  #   end
  # end
end

# UserGame < Game
class UserGame < Game
  define_steps

  def initialize
    p 'Hello! what is your name?'
    super(User.new(gets))
  end

  def choosing
    steps = self.class.steps
    steps -= ['take'] if player.cards.count > 3
    super(steps)
  end
end

# DealerGame < Game
class DealerGame < Game
  define_steps delete: 'open'

  def initialize
    super(Dealer.new)
  end

  def choosing
    steps = self.class.steps
    steps -= ['next'] if player.points < 17
    steps -= ['take'] if player.points > 18
    super(steps) unless steps.nil?
  end
end

user_game = UserGame.new
dealer_game = DealerGame.new
# loop
user_game.choosing
dealer_game.choosing
# rescue
# init
exit
