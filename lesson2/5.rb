# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) Алгоритм опредления високосного года: www.adm.yar.ru

require 'time'

class CalcDate
   COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  
  def initialize
    print 'day(1-31): '
    @day = gets.chomp.to_i
    print 'month(1-12): '
    @month = gets.chomp.to_i
    print "year(0-#{Time.now.year}): "
    @year = gets.chomp.to_i
  end

  def gregorian_leap?
   @year%4 == 0 and @year%100 != 0 or @year%400 == 0 
  end

  def days_in_month(month)
    return 29 if month == 2 and gregorian_leap?
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def days_array
    (1..@month).map { |month| days_in_month(month) }
  end

  def all_days
    days_array.sum
  end

  def serial_number
    all_days - days_in_month(@month) + @day
  end
end

my_date = CalcDate.new
puts "Day serial number is #{my_date.serial_number}"
