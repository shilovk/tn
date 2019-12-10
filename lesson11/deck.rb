# frozen_string_literal: true

require_relative 'modules/cards_generate'
require_relative 'card'

# Deck
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    CardsGenerate.cards_values.each do |(card, point)|
      @cards << Card.new(card, point)
    end
  end

  def take_card
    card = cards.sample
    cards.delete(card)
    card
  end
end
