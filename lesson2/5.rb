# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) Алгоритм опредления високосного года: www.adm.yar.ru

require 'Date'

class CalcDate
  def initialize
    print 'day(1-31): '
    @day = gets.chomp.to_i
    print 'month(1-12): '
    @month = gets.chomp.to_i
    print "year(0-#{Date.today.year}): "
    @year = gets.chomp.to_i
  end

  def days_in_month m, y
    Date.new(y, m, -1).day
  end

  def days_of_months
    @days_of_months = (1..@month).inject({}) { |memo, m| memo[m] = days_in_month(m, @year); memo }
  end

  def all_days
    @days_of_months.inject(0) { |sum, (m,d)| sum += d }
  end

  def serial_number
    all_days - @days_of_months[@month] + @day
  end
end

my_date = CalcDate.new
puts "Day serial number is #{my_date.serial_number}"
