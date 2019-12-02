# frozen_string_literal: true

# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
# Если D > 0, то выводим дискриминант и 2 корня
# Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
# Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать Math.sqrt

class Equation
  def initialize
    puts 'Please, enter three coefficients for equation:'
    @a = gets.to_f
    @b = gets.to_f
    @c = gets.to_f
  end

  def discriminant
    @d = @b**2 - 4 * @a * @c
  end

  def calc_roots
    if @d.positive?
      puts "x1 = #{x1}"
      puts "x2 = #{x2}"
    elsif @d.zero?
      puts "x1 = #{x1}"
    else
      'No roots'
    end
  end

  def x1
    (-@b + Math.sqrt(@d)) / (2.to_f * @a)
  end

  def x2
    (-@b - Math.sqrt(@d)) / (2.to_f * @a)
  end
end

equation = Equation.new
puts "Discriminant = #{equation.discriminant}"
puts equation.calc_roots
