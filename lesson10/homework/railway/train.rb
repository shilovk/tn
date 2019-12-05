# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'
require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'show'

# Train
class Train
  extend Accessors
  include Validation
  include CompanyName
  include InstanceCounter
  include Show

  TRAIN_TYPES = %w[passenger cargo].freeze
  NUMBER_FORMAT = /^[[a-z]\d]{3}[-]?([a-z]{2}|[\d]{2})$/i.freeze

  @@trains = []

  attr_accessor_with_history :coaches
  attr_reader :speed, :type, :actual_station, :number

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number = nil)
    @number = number.to_s.chomp
    @speed = 0
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

  def add_route(route)
    @route = route
    actual_station_set
  end

  def actual_station_set(direction = nil)
    @actual_station&.send_train(self)
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
    raise "The coach #{coach} is on the train #{self}" if coaches.include?(coach)
    raise 'Wrong type of coach for the train' unless coach.of_type?(type)

    self.coaches = coach
  end

  def remove_coach(coach)
    return unless speed.zero?

    @coaches.delete(coach) if coaches.include?(coach)
  end

  def each_coach(block_for)
    coaches.each_with_index { |el, i| block_for.call(el, i) }
  end

  def validate!
    super
    raise 'Number must be at least 5 symbols' if number.to_s.length < 5

    true
  end
end

# PassengerTrain < Train
class PassengerTrain < Train
  def initialize(number = nil)
    @type = TRAIN_TYPES.index('passenger')
    super(number)
  end
end

# CargoTrain < Train
class CargoTrain < Train
  def initialize(number = nil)
    @type = TRAIN_TYPES.index('cargo')
    super(number)
  end
end
