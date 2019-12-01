# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'show'

# Station
class Station
  include InstanceCounter
  include Show
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
    validate!
    Station.all << self
    register_instance
  end

  def self.find(value)
    value = value.to_s.chomp
    all.find { |element| element.title == value }
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
  rescue
    false
  end

  def each_train
    trains.each { |el| yield(el) }
  end

  protected

  def validate!
    raise 'Title can\'t be nil' unless title
    raise 'Title has invalid format' unless title.is_a? String
    raise 'Title can\'t be at least 3 symbols' if title.length < 3

    true
  end
end
