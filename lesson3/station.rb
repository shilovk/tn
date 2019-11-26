# frozen_string_literal: true

# Stattion
class Station
  attr_reader :trains, :title

  def initialize(title)
    @title = title
    @trains = []
    puts "Station #{title} created!"
  end

  def add_train(train)
    if trains.include?(train)
      raise "The train #{train} is already at the station #{title}"
    end

    trains << train
    puts "Train #{train} arrived at the station #{title}"
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
    puts "Train #{train} left the station #{title}"
  end
end
