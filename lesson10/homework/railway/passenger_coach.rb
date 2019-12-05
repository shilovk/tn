# frozen_string_literal: true

# PassengerCoach < Coach
class PassengerCoach < Coach
  def initialize(size)
    @type = COACH_TYPES.index('passenger')
    super
  end

  def size_set(_size = 1)
    super(1)
  end
end
