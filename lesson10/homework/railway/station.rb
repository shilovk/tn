# frozen_string_literal: true

require_relative 'modules/accessors'
require_relative 'modules/validation'
require_relative 'modules/instance_counter'
require_relative 'modules/class_instances'
require_relative 'modules/show'

# Station
class Station
  extend Accessors
  include Validation
  include InstanceCounter
  include ClassInstances
  include Show

  class_attr_accessor_with_history :all
  attr_accessor_with_history :trains
  attr_reader :title

  validate :title, :presence
  validate :title, :type, String

  def initialize(title = nil)
    @title = title
    validate!
    Station.all = self
    register_instance
  end

  def self.find(value)
    value = value.to_s.chomp
    all.find { |element| element.title == value }
  end

  def add_train(train)
    raise "The train #{train} is already at the station #{title}" if trains.include?(train)

    self.trains = train
  end

  def show_trains_by_type(type_of_train)
    puts "Trains by type '#{type_of_train}':"
    puts Train.get_trains_by_type(trains, type_of_train).count
  end

  def send_train(train)
    raise("The train #{train} is not at the station #{title}") unless trains.include?(train)

    trains.delete(train)
  end

  def each_train
    trains.each { |el| yield(el) }
  end

  protected

  def validate!
    super
    raise 'Title can\'t be at least 3 symbols' if title.length < 3

    true
  end
end
