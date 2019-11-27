# frozen_string_literal: true

require 'pry'
require_relative 'station'
require_relative 'route'
require_relative 'coach'
require_relative 'train'

# RailWay
class RW
  attr_reader :trains, :routes, :stations, :coaches

  def initialize
    @trains = {}
    @routes = {}
    @stations = {}
    @coaches = {}
    init0
  end

  def init1
    %w[Moscow Sochi Krasnodar Adler].each do |name|
      stations[name] = Station.new(name)
    end
    Station.all
    puts stations
    puts Station.instances
  end

  def init2
    number = trains.count
    types = Train::TRAIN_TYPES
    puts 'Select type of train:'
    types.each_with_index { |type, i| puts "#{i} - #{type} " }
    type = types[gets.chomp.to_i]
    my_class = "#{type.capitalize}Train"
    trains[number] = Object.const_get(my_class).new(number)
    trains[number].company = 'RZD'
    trains[number].company
    puts trains
    puts Train.find(0)
    puts PassengerTrain.instances
    puts CargoTrain.instances
  end

  def init3
    number = routes.count
    routes[number] = Route.new(stations['Moscow'], stations['Sochi'])
    routes[number].add_interim(stations['Krasnodar'])
    routes[number].add_interim(stations['Adler'])
    routes[number].remove_interim(stations['Adler'])
    routes[number].show_stations
    puts routes
    puts Route.instances
  end

  def init4
    puts '1'
    trains[0].add_route(routes[0])
    puts trains
  end

  def init5
    number = coaches.count
    types = Coach::COACH_TYPES
    puts 'Select type of coach:'
    types.each_with_index { |type, i| puts "#{i} - #{type} " }
    type = types[gets.chomp.to_i]
    my_class = "#{type.capitalize}Coach"
    coaches[number] = Object.const_get(my_class).new
    coaches[number].company = 'RZD'
    coaches[number].company
    puts coaches
    trains[0].add_coach(coaches[number])
    puts trains
  end

  def init6
    puts 'Select direction: next / back'
    direction = gets.chomp.to_s
    trains[0].actual_station_set(direction)
  end

  def init7
    puts stations
  end

  def init0
    loop do 
      puts '0 - Выйти'
      puts '1 - Создавать станции'
      puts '2 - Создавать поезда'
      puts '3 - Создавать маршруты и управлять станциями в нем (добавлять, удалять)'
      puts '4 - Назначать маршрут поезду'
      puts '5 - Добавлять вагоны к поезду / Отцеплять вагоны от поезда'
      puts '6 - Перемещать поезд по маршруту вперед и назад'
      puts '7 - Просматривать список станций и список поездов на станции'
      key = gets.chomp.to_i
      break if key.zero?

      send("init#{key}")
    end
  end

  def starting
    init1
    init2
    init3
    init4
    init5
    init6
    init6
    init7
  end
end
