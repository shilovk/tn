# frozen_string_literal: true

# Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

class Triangle
  def initialize
    puts 'Please, enter base of triangle:'
    @a = gets.to_f
    puts 'Please, enter height of triangle:'
    @h = gets.to_f
  end

  def square
    0.5 * @a * @h
  end
end

triangle = Triangle.new
puts "The square of the triangle is #{triangle.square}"
