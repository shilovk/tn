# frozen_string_literal: true

require 'pry'
require_relative 'station'
require_relative 'route'
require_relative 'coach'
require_relative 'train'

# RailWay
class RailWay
  attr_reader :trains, :routes, :coaches

  def initialize
    init0
  end

  def init1
    %w[Moscow Krasnodar Adler Sochi].each do |name|
      Station.new(name)
    end
    puts Station.all.map(&:show)
    puts Station.instances
  end

  def init2
    types = Train::TRAIN_TYPES
    puts 'Select type of train:'
    types.each_with_index { |type, i| puts "#{i} - #{type} " }
    type = types[gets.chomp.to_i]
    my_class = "#{type.capitalize}Train"
    puts 'Train number:'
    number = gets
    train = Object.const_get(my_class).new(number)
    puts 'Train company:'
    train.company = gets.to_s.chomp
    puts Train.all.map(&:show)
    puts Train.find(number).show
  rescue => e
    puts e.message
    puts e.backtrace.inspect
    retry
  end

  def init3
    route = Route.new(Station.find('Moscow'), Station.find('Sochi'))
    route.add_interim(Station.find('Krasnodar'))
    route.add_interim(Station.find('Adler'))
    route.remove_interim(Station.find('Adler'))
    route.show_stations
    puts Route.all.map(&:show)
    puts Route.instances
  end

  def init4
    Train.all.first.add_route(Route.all.first)
    puts Train.all.inspect
  end

  def init5
    types = Coach::COACH_TYPES
    puts 'Select type of coach:'
    types.each_with_index { |type, i| puts "#{i} - #{type} " }
    type = types[gets.chomp.to_i]
    my_class = "#{type.capitalize}Coach"
    coach = Object.const_get(my_class).new
    puts 'Coach company:'
    coach.company = gets.to_s.chomp
    coach.company
    puts Coach.all.map(&:show)
    puts Train.all.first.add_coach(coach)
    puts Train.all.map(&:show)
  end

  def init6
    puts 'Select direction: next / back'
    direction = gets.chomp.to_s
    Train.all.first.actual_station_set(direction)
    puts Train.all.first.show
  end

  def init7
    puts Station.all.map(&:show)
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

RailWay.new
exit
