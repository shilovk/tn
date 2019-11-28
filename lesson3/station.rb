# frozen_string_literal: true

require_relative 'instance_counter'

# Station
class Station
  include InstanceCounter
  attr_reader :trains, :title
  @all = []
  class << self
    attr_reader :all

    protected

    attr_writer :all
  end

  def initialize(title = nil)
    @title = title
    @trains = []
    valid?
    Station.all << self
    register_instance
  end

  def add_train(train)
    if trains.include?(train)
      raise "The train #{train} is already at the station #{title}"
    end

    trains << train
  end

  def show_trains_by_type(type_of_train)
    puts "Trains by type '#{type_of_train}':"
    puts Train.get_trains_by_type(trains, type_of_train).count
  end

  def send_train(train)
    unless trains.include?(train)
      raise("The train #{train} is not at the station #{title}")
    end

    trains.delete(train)
  end

  def valid?
    validate!
  end

  protected

  def validate!
    raise 'Title can\'t be nil' if title.nil?
    raise 'Title has invalid format' unless title.is_a? String
    raise 'Title can\'t be at least 3 symbols' if title.length < 3

    true
  end
end
