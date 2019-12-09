# frozen_string_literal: true

require_relative 'game'

# UserGame < Game
class UserGame < Game
  define_steps

  def initialize(name = nil)
    super(User.new(name || Inerface.get_user_name))
  end

  def choosing
    steps = self.class.steps
    steps -= ['taking'] if player.cards.count == 3
    super(steps)
  end
end
