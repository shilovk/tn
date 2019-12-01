# frozen_string_literal: true

# CargoCoach < Train
class CargoCoach < Coach

  def initialize(size)
    @type = COACH_TYPES.index('cargo')
    super
  end
end
