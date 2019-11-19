=begin
Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), равнобедренным (т.е. у него равны любые 2 стороны)  или равносторонним (все 3 стороны равны) и выводит результат на экран. Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.
=end

class Triangle
  def self.start
    triangle = Triangle.new
    triangle.setup
    triangle.rectangular
    triangle.isosceles
    triangle.equilateral
  end

  def setup
    puts 'Please, enter three sides of the triangle:'
    @sides = [gets.to_f, gets.to_f, gets.to_f]
    @max_side = @sides.max
    @other_sides = @sides.select{ |el| el != @max_side }
    @number_equal_sides = @sides.uniq.map{ |el| @sides.count(el) }.max
  end

  def equilateral?
    @number_equal_sides == 3
  end

  def isosceles?
    @number_equal_sides == 2
    # [2,3].include? @number_equal_sides
  end

  def rectangular?
    @other_sides.inject(0){ |sum, el| (sum + el**2) } == @max_side**2
  end

  def rectangular
    return false if equilateral?
    puts 'The triangle is rectangular.' if rectangular?
  end

  def isosceles
    puts 'The triangle is isosceles' if equilateral? || isosceles?
  end

  def equilateral
    puts 'The triangle is equilateral' if equilateral? 
  end
 
end

Triangle.start
