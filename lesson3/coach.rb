# frozen_string_literal: true

# Coach
class Coach
  COACH_TYPES = %w[passenger cargo]

  def initialize
    @type = nil
  end

  def of_type?(checking_type)
    @type == checking_type
  end
end

# PassengerCoach < Coach
class PassengerCoach < Coach
  def initialize
    @type = COACH_TYPES.index('passenger')
  end
end

# CargoCoach < Train
class CargoCoach < Coach
  def initialize
    @type = COACH_TYPES.index('cargo')
  end
end
