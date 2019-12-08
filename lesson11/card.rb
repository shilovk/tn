# frozen_string_literal: true

# Card
class Card
  ALL = { '2+' => 2, '3+' => 3, '4+' => 4, '5+' => 5, '6+' => 6, '7+' => 7, '8+' => 8, '9+' => 9, '10+' => 10, 'J+' => 10, 'Q+' => 10, 'K+' => 10, 'A+' => [1, 11], '2<' => 2, '3<' => 3, '4<' => 4, '5<' => 5, '6<' => 6, '7<' => 7, '8<' => 8, '9<' => 9, '10<' => 10, 'J<' => 10, 'Q<' => 10, 'K<' => 10, 'A<' => [1, 11], '2^' => 2, '3^' => 3, '4^' => 4, '5^' => 5, '6^' => 6, '7^' => 7, '8^' => 8, '9^' => 9, '10^' => 10, 'J^' => 10, 'Q^' => 10, 'K^' => 10, 'A^' => [1, 11], '2<>' => 2, '3<>' => 3, '4<>' => 4, '5<>' => 5, '6<>' => 6, '7<>' => 7, '8<>' => 8, '9<>' => 9, '10<>' => 10, 'J<>' => 10, 'Q<>' => 10, 'K<>' => 10, 'A<>' => [1, 11] }.freeze

  attr_reader :card, :point
  alias name card

  @@cards = Card::ALL.keys

  def initialize
    @card = @@cards[rand(@@cards.size)]
    @point = Card::ALL[@card]
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
