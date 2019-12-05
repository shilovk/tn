# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'show'
require_relative 'station'

# Route
class Route
  extend Accessors
  include Validation
  include InstanceCounter
  include Show

  @all = []
  class << self
    attr_reader :all

    protected

    attr_writer :all
  end

  attr_accessor_with_history :interim
  attr_reader :from, :to

  validate :from, :presence
  validate :from, :type, Station
  validate :to, :presence
  validate :to, :type, Station

  def initialize(from = nil, to = nil)
    @from = from
    @to = to
    validate!
    Route.all << self
    register_instance
  end

  def add_interim(interim)
    self.interim = interim
  end

  def remove_interim(interim)
    return unless self.interim.include?(interim)

    self.interim.delete(interim)
  end

  def stations
    [from, interim, to].flatten
  end

  def show_stations
    puts [stations].join(', ')
  end

  def actual_station_by(direction = nil, actual_station = nil)
    return from if actual_station.nil?

    case direction
    when 'next'
      to?(actual_station) ? to : find_actual_station(actual_station, 1)
    when 'back'
      from?(actual_station) ? from : find_actual_station(actual_station, -1)
    else
      actual_station
    end
  end

  def from?(station)
    station == from
  end

  def to?(station)
    station == to
  end

  def find_actual_station(old_station, step = 0)
    stations[index_of_station(old_station) + step]
  end

  def index_of_station(station)
    stations.index(station)
  end

  def back_station(actual_station)
    i = index_of_station(actual_station)
    from?(actual_station) ? 'none' : stations[i - 1]
  end

  def next_station(actual_station)
    i = index_of_station(actual_station)
    to?(actual_station) ? 'none' : stations[i + 1]
  end

  def three_stations(actual_station)
    [back_station(actual_station), actual_station, next_station(actual_station)]
  end
end
