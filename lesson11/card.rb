# frozen_string_literal: true

require_relative 'modules/cards_generate'

# Card
class Card
  attr_reader :card, :point
  alias name card

  @@cards = CardsGenerate.cards
  @@cards_values = CardsGenerate.cards_values

  def initialize
    @card = @@cards[rand(@@cards.size)]
    @point = @@cards_values[@card]
    @@cards.delete(@card)
  end

  def self.names(cards)
    cards.map(&:name)
  end

  def self.points(cards)
    cards.map(&:point)
  end

  def self.calc(points)
    twice_points = points.select { |el| el.is_a? Array }
    points -= twice_points
    calc = points.sum
    twice_points.each do
      calc += 11
      calc -= 10 if calc > 21
    end
    calc
  end
end
