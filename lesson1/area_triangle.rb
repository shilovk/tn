=begin
Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.
=end

class Triangle
  attr_writer :a, :h

  def square
    (1.to_f/2.to_f)*@a.to_f*@h.to_f
  end
end

triangle = Triangle.new
puts 'Please, enter base of triangle:'
triangle.a = gets
puts 'Please, enter height of triangle:'
triangle.h = gets
puts "The square of the triangle is #{triangle.square}"
