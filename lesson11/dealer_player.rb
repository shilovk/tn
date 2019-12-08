# frozen_string_literal: true

require_relative 'player'

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

  def cards_names(*args)
    return super() if args[0] && args[0][:show]

    cards.map { '*' }
  end
end
