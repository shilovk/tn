# frozen_string_literal: true

require_relative 'card'

# Player
class Player
  attr_reader :cards, :sum, :name
  attr_accessor :money

  def initialize
    @money = 100
    @cards = []
  end

  def add_card
    cards << Card.new
  end

  # def calc
  #   @sum += @@cards.last
  #   raise 'you lose' if (@sum || @sum - 10) > 21
  #   # rescue => e
  #   #   p e.message
  # end

  # def calc_sum(card)
  #   @sum = Card.value_of(card)
  # end
end

# User < Player
class User < Player
  def initialize(name)
    @type = 'user'
    @name = name.to_s.chomp
    super()
  end
end

# Dealer < Player
class Dealer < Player
  def initialize
    @type = 'dealer'
    @name = 'Dealer'
    super
  end
end
