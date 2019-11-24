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

  def move_coach(operation)
    if self.speed.zero?
      case operation
      when 'add'
        @coach_count += 1
      when 'remove'
        @coach_count -= 1 unless self.coach_count.zero?
      end
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

  def self.get_types_of_trains(trains)
    trains.each_with_object(Hash.new(0)) { |train, memo| memo[TRAIN_TYPES[train.type]] += 1 }
  end
end
