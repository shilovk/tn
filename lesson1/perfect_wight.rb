# frozen_string_literal: true

# Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле <рост> - 110, после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

class Human
  attr_reader :first_name

  def initialize
    puts 'Hi! What is your name?'
    @first_name = gets.chomp
    puts 'Please, enter your height:'
    @height = gets.to_i
  end

  def perfect_weight
    (@height - 110) * 1.15
  end

  def diagnosis_weight(value)
    puts('Ваш вес уже оптимальный') if value.negative?
  end
end

human = Human.new
puts "#{human.first_name}, your perfect weight is #{human.perfect_weight}kg"
human.diagnosis_weight(human.perfect_weight)
