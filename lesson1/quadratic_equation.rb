=begin
Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
  Если D > 0, то выводим дискриминант и 2 корня
  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать Math.sqrt
=end

class Equation
  attr_writer :a, :b, :c
  attr_reader :discriminant

  def discriminant
    @b**2 - 4*@a*@c 
  end

  def calc_roots
    if discriminant > 0
      puts "x1 = #{x1}"
      puts "x2 = #{x2}"
    elsif discriminant == 0
      puts "x1 = #{x1}"
    else
      'No roots'
    end
  end

  def x1
    ( -@b + Math.sqrt(discriminant) )/( 2.to_f * @a )
  end

  def x2
    ( -@b - Math.sqrt(discriminant) )/( 2.to_f * @a )
  end
end

equation = Equation.new
puts 'Please, enter three coefficients for equation:'
equation.a = gets.to_f
equation.b = gets.to_f
equation.c = gets.to_f
puts "Discriminant = #{equation.discriminant}"
puts equation.calc_roots

