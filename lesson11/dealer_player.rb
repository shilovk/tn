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
    args = args.flatten[0] || {}
    return super() if args[:show]

    cards.map { '*' }
  end
end
