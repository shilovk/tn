# frozen_string_literal: true

require 'pry'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'coach'
require_relative 'passenger_coach'
require_relative 'cargo_coach'

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
  rescue StandardError => e
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
    puts 'Enter seats/space:'
    size = gets
    coach = Object.const_get(my_class).new(size)
    puts 'Coach company:'
    coach.company = gets.to_s.chomp
    coach.company
    puts Coach.all.map(&:show)
    puts Train.all.first.add_coach(coach)
    puts Train.all.map(&:show)
    Train.all.first.each_coach Coach.proc_show_template
  end

  def init6
    puts 'Select direction: next / back'
    direction = gets.chomp.to_s
    Train.all.first.actual_station_set(direction)
    puts Train.all.first.show
    Train.all.first.each_coach Coach.proc_show_template
  end

  def init7
    puts Station.all.map(&:show)
    Station.all.each do |station|
      puts "Trains on station #{station.title}:"
      station.each_train do |el|
        puts "- Train #{el.number} #{el.type} #{el.coaches.count}"
      end
    end
  end

  def init8
    puts 'Occupied size:'
    size = gets if Coach.all.first.type == 1
    Coach.all.first.size_set size || nil
    Train.all.first.each_coach Coach.proc_show_template
  end

  def init0
    loop do
      puts '0 - Выйти'
      puts '1 - Создавать станции'
      puts '2 - Создавать поезда'
      puts '3 - Создавать маршруты и управлять станциями в нем'
      puts '4 - Назначать маршрут поезду'
      puts '5 - Добавлять вагоны к поезду / Отцеплять вагоны от поезда'
      puts '6 - Перемещать поезд по маршруту вперед и назад'
      puts '7 - Просматривать список станций и список поездов на станции'
      puts '8 - Занимать место в вагоне'
      key = gets.chomp.to_i
      break if key.zero?

      send("init#{key}")
    end
  end
end

RailWay.new
exit
