# frozen_string_literal: true

require_relative 'game'

# DealerGame < Game
class DealerGame < Game
  define_steps delete: 'opening'

  def initialize
    super(Dealer.new)
  end

  def choosing
    steps = self.class.steps
    steps -= ['next'] if score < 17
    steps -= ['taking'] if score > 18
    super(steps) unless steps.nil?
  end
end
