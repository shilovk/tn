# frozen_string_literal: true

require_relative 'card'

# Player
class Player
  attr_reader :cards, :points, :name
  attr_accessor :money

  def initialize
    @money = 100
    @points = 0
    @cards = []
  end

  def add_card
    card = Card.new
    cards << card
    self.points = cards_points
  end

  def cards_names
    Card.names(cards)
  end

  def cards_points
    Card.points(cards)
  end

  protected

  def points=(points)
    @points = Card.calc(points)
  end
end

# User < Player
class User < Player
  def initialize(name)
    @type = 'user'
    @name = name.to_s.chomp
    super()
  end

  def user?
    true
  end
end

# Dealer < Player
class Dealer < Player
  def initialize
    @type = 'dealer'
    @name = 'Dealer'
    super
  end

  def user?
    false
  end

  def cards_names(*hide)
    hide ? cards.map { '*' } : super()
  end
end
