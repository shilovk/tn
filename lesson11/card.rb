# frozen_string_literal: true

# Card
class Card
  attr_accessor :name, :point
  # alias name card

  class << self
    def names(cards)
      cards.map(&:name)
    end

    def points(cards)
      cards.map(&:point)
    end

    def calc(points)
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

  def initialize(name, point)
    @name = name
    @point = point
  end
end
