# frozen_string_literal: true

require_relative 'modules/validation'

# CargoCoach < Train
class CargoCoach < Coach
  include Validation

  def initialize(size)
    @type = COACH_TYPES.index('cargo')
    super
  end
end
