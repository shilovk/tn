# frozen_string_literal: true

require_relative 'modules/generate'
require_relative 'card'

# Deck
class Deck
  attr_reader :cards

  def initialize
    @cards = Generate.cards_values.each_with_object([]) do |(name, point), memo|
      memo << Card.new(name, point)
    end
  end

  def take_card
    cards.delete(cards.sample)
  end

  protected

  attr_writer :cards
end
