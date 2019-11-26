# frozen_string_literal: true

# Train
class Train
  attr_reader :speed, :coaches, :type, :actual_station
  TRAIN_TYPES = %w[passenger cargo]

  def initialize(number)
    @number = number
    @speed = 0
    @actual_station = nil
    @type = nil
    @coaches = []
  end

  def add_speed(speed)
    @speed += speed
  end

  def stop_speed
    @speed = 0
  end

  def remove_coach(coach)
    return unless speed.zero?

    @coaches.delete(coach) if coaches.include?(coach)
  end

  def add_route(route)
    @route = route
    actual_station_set
  end

  def actual_station_set(direction = nil)
    @actual_station.send_train(self) unless @actual_station.nil?
    @actual_station = @route.actual_station_by(direction, @actual_station)
    @actual_station.add_train(self)
  end

  def three_stations
    @route.three_stations(@actual_station)
  end

  def self.trains_by_type(trains, type_of_train)
    trains.select { |train| train.type == TRAIN_TYPES.index(type_of_train) }
  end

  def add_coach(coach)
    return unless speed.zero?

    coaches.push(coach) if coach.of_type?(type) && !coaches.include?(coach)
  end

  protected

  # Вызываем из подкласса, когда уже понятно какого типа поезд
  def coaches=(coaches_array)
    coaches_array.each { |coach| add_coach(coach) }
  end
end

# PassengerTrain < Train
class PassengerTrain < Train
  def initialize(name, coaches = [])
    super(name)
    @type = TRAIN_TYPES.index('passenger')
    @coaches = coaches
  end
end

# CargoTrain < Train
class CargoTrain < Train
  def initialize(name, coaches = [])
    super(name)
    @type = TRAIN_TYPES.index('cargo')
    @coaches = coaches
  end
end
