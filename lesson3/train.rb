# frozen_string_literal: true

require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'show'
require_relative 'coach'

# Train
class Train
  include CompanyName
  include InstanceCounter
  include Show
  attr_reader :speed, :coaches, :type, :actual_station, :number
  TRAIN_TYPES = %w[passenger cargo]
  @@trains = []
  NUMBER_FORMAT = /^[[a-z]\d]{3}[-]?([a-z]{2}|[\d]{2})$/i

  def initialize(number = nil)
    @number = number.to_s.chomp
    @speed = 0
    @coaches = []
    validate!
    @@trains << self
    register_instance
  end

  def self.all
    @@trains
  end

  def self.find(value)
    value = value.to_s.chomp
    @@trains.find { |element| element.number == value }
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

  def valid?
    validate!
  rescue
    false
  end

  def execute(block_for)
    coaches.each { |el| block_for.call(el) }
  end

  protected

  # Вызываем из подкласса, когда уже понятно какого типа поезд
  def coaches=(coaches_array)
    coaches_array.each { |coach| add_coach(coach) }
  end

  def validate!
    raise 'Number can\'t be nil' unless number
    raise 'Number must be at least 5 symbols' if number.to_s.length < 5
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    
    true
  end
end

# PassengerTrain < Train
class PassengerTrain < Train
  def initialize(number = nil, coaches = [])
    @type = TRAIN_TYPES.index('passenger')
    @coaches = coaches
    super(number)
  end
end

# CargoTrain < Train
class CargoTrain < Train
  def initialize(number = nil, coaches = [])
    @type = TRAIN_TYPES.index('cargo')
    @coaches = coaches
    super(number)
  end
end

