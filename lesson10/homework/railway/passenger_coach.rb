# frozen_string_literal: true

require_relative 'modules/validation'

# PassengerCoach < Coach
class PassengerCoach < Coach
  include Validation

  def initialize(size)
    @type = COACH_TYPES.index('passenger')
    super
  end

  def size_set(_size = 1)
    super(1)
  end
end
