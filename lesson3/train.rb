class Train
  attr_reader :speed, :coach_count, :type
  TRAIN_TYPES = ['freight', 'passenger']

  def initialize(number, type, coach_count)
    @number = number
    @type = TRAIN_TYPES.index(type)
    @coach_count = coach_count
    @speed = 0
    @actual_station = nil
  end

  def add_speed(speed)
    @speed += speed
  end

  def stop_speed
    @speed = 0
  end

  def add_coach
    @coach_count += 1 if self.speed.zero?
  end

  def remove_coach
    if self.speed.zero?
      @coach_count -= 1 unless self.coach_count.zero?
    end
  end

  def add_route(route)
    @route = route
    set_actual_station
  end

  def set_actual_station(direction = nil)
    @actual_station = @route.get_actual_station_by(direction, @actual_station)
  end

  def three_stations
    @route.get_three_stations(@actual_station)
  end

  def self.get_trains_by_type(trains, type_of_train)
    trains.each_with_object([]) { |train, memo| memo << train if train.type == TRAIN_TYPES.index(type_of_train) }
  end
end
