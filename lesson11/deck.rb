# frozen_string_literal: true

require_relative 'modules/cards_generate'
require_relative 'card'

# Deck
class Deck
  @cards = []
  class << self
    attr_reader :cards
  end

  def initialize
    CardsGenerate.cards_values.each do |(card, point)|
      Deck.cards << Card.new(card, point)
    end
  end

  def take_card
    @card = Deck.cards[rand(Deck.cards.size)]
    Deck.cards.delete(@card)
    @card
  end
end
