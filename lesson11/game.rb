# frozen_string_literal: true

require_relative 'player'
require_relative 'card'

# Game
class Game
  def initialize
    p 'Hello! What is your name?'
    @user = User.new(gets)
    @dealer = Dealer.new
    game
  end

  def game
    @bank = 0
    start_for(@user)
    start_for(@dealer)
  end

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

  # def choosing_for(player)
  #   p player.menu
  #   choose = gets.to_i
  # end

  protected

  def start_for(player)
    p "#{player.name}, you are taking 2 cards"
    player.money -= 10
    @bank += 10
    player.add_card
    player.add_card
    sleep(2)
    p 'And they are:'
    p Card.names(player.cards)
    p Card.values(player.cards)
    p player
    gets
  end

  #  def new_card
  #   raise 'You can not take over 3 cards!' if @@cards.count == 3

  #   add_card
  # end

  # def open_cards

  # end
end

Game.new
exit
