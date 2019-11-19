=begin
Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле <рост> - 110, после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
=end

class Human
  attr_reader :first_name

  def first_name=(value)
    @first_name = value.chomp
  end

  def height=(value)
    @height = value.to_i
  end

  def perfect_weight
    calc = (@height - 110)*1.15
  end

  def diagnosis_weight(value)
    puts('Ваш вес уже оптимальный') if value < 0
  end
end

human = Human.new
puts 'Hi! What is your name?'
human.first_name = gets
puts 'Please, enter your height:'
human.height = gets
puts "#{human.first_name}, your perfect weight is #{human.perfect_weight}kg"
human.diagnosis_weight(human.perfect_weight)
