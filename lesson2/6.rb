# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".


class Order
  def initialize
    @basket = Hash.new('empty busket')
    loop do
      puts 'Please enter title:'
      title = gets.chomp
      break if title == 'stop'
      puts 'price:'
      price = gets.chomp.to_i
      puts 'count:'
      count = gets.chomp.to_f
      @basket[title] = [ { price => count } , price * count]
    end
  end

  def total
    @basket.inject(0) do |sums, (el, (val, sum))|
      puts "#{el} => #{val} = #{sum}"
      sums += sum
    end
  end
end

puts Order.new.total
