# frozen_string_literal: true

require_relative 'game'

# UserGame < Game
class UserGame < Game
  define_steps

  def initialize(name = nil)
    name ||= Inerface.get_user_name
    super(User.new(name))
  end

  def choosing
    steps = self.class.steps
    steps -= ['taking'] if player.cards.count == 3
    super(steps)
  end
end
