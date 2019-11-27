# frozen_string_literal: true

require_relative 'company_name'

# Coach
class Coach
  include CompanyName
  COACH_TYPES = %w[passenger cargo]

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
