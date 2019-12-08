# frozen_string_literal: true

require_relative 'card'

# Player
class Player
  attr_reader :cards, :name
  attr_accessor :money

  def initialize
    @money = 100
    @cards = []
  end

  def add_card(card)
    cards << card
  end

  def cards_names
    Card.names(cards)
  end

  def cards_points
    Card.points(cards)
  end
end
