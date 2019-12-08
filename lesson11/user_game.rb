# frozen_string_literal: true

require_relative 'game'

# UserGame < Game
class UserGame < Game
  define_steps

  def initialize(name = nil)
    p 'Hello! what is your name?' unless name
    super(User.new(name || gets))
  end

  def choosing
    steps = self.class.steps
    steps -= ['taking'] if player.cards.count == 3
    super(steps)
  end
end
