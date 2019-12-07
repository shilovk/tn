# frozen_string_literal: true

require_relative 'player'
require_relative 'card'

# Game
class Game
  STEPS = { 'next' => 'next step', 'take' => 'take card', 'open' => 'open cards'}.freeze
  
  @bank = 0
  @steps = Game::STEPS.keys
  class << self
    attr_accessor :bank
    attr_reader :steps
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
  end

  def choosing(steps)
    p 'Please choose:'
    steps.each { |step| p Game::STEPS[step] }
    choose = gets.chomp
    player.add_card
    p player.cards_names
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
  def initialize
    p 'Hello! what is your name?'
    @player = User.new(gets)
    super(@player)
  end

  def choosing(steps = Game.steps)
    steps.delete('take') if player.cards.count > 3
    super(steps)
  end
end

# DealerGame < Game
class DealerGame < Game
  def initialize
    @player = Dealer.new
    super(@player)
  end

  def choosing(steps = Game.steps)
    steps.delete('next') if player.points < 17
    steps.delete('take') if player.points > 18
    steps.delete('open')
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
