# frozen_string_literal: true

# Card
class Card
  ALL = { '2+' => 2, '3+' => 3, '4+' => 4, '5+' => 5, '6+' => 6, '7+' => 7, '8+' => 8, '9+' => 9, '10+' => 10, 'J+' => 10, 'Q+' => 10, 'K+' => 10, 'A+' => [1, 11], '2<' => 2, '3<' => 3, '4<' => 4, '5<' => 5, '6<' => 6, '7<' => 7, '8<' => 8, '9<' => 9, '10<' => 10, 'J<' => 10, 'Q<' => 10, 'K<' => 10, 'A<' => [1, 11], '2^' => 2, '3^' => 3, '4^' => 4, '5^' => 5, '6^' => 6, '7^' => 7, '8^' => 8, '9^' => 9, '10^' => 10, 'J^' => 10, 'Q^' => 10, 'K^' => 10, 'A^' => [1, 11], '2<>' => 2, '3<>' => 3, '4<>' => 4, '5<>' => 5, '6<>' => 6, '7<>' => 7, '8<>' => 8, '9<>' => 9, '10<>' => 10, 'J<>' => 10, 'Q<>' => 10, 'K<>' => 10, 'A<>' => [1, 11] }.freeze

  attr_reader :card, :value
  alias name card

  @@cards = Card::ALL.keys

  def initialize
    @card = @@cards[rand(@@cards.size)]
    @value = Card::ALL[@card]
    @@cards.delete(@card)
  end

  def self.values(cards)
    cards.map(&:value)
  end

  def self.names(cards)
    cards.map(&:name)
  end
end
