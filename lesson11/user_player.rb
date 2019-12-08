# frozen_string_literal: true

require_relative 'player'

# User < Player
class User < Player
  def initialize(name)
    @type = 'user'
    @name = name.to_s.chomp.capitalize
    super()
  end

  def user?
    true
  end

  def cards_names(*_args)
    super()
  end
end
