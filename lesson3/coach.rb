# frozen_string_literal: true

require_relative 'company_name'
require_relative 'show'

# Coach
class Coach
  include CompanyName
  include Show
  COACH_TYPES = %w[passenger cargo]
  @all = []
  class << self
    attr_reader :all

    protected

    attr_writer :all
  end

  def initialize
    Coach.all << self
  end

  def of_type?(checking_type)
    @type == checking_type
  end
end

# PassengerCoach < Coach
class PassengerCoach < Coach
  def initialize
    @type = COACH_TYPES.index('passenger')
    super
  end
end

# CargoCoach < Train
class CargoCoach < Coach
  def initialize
    @type = COACH_TYPES.index('cargo')
    super
  end
end
