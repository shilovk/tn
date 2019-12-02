# frozen_string_literal: true

# 3. Заполнить массив числами фибоначчи до 100

def fibonachi(max_value)
  fib = [0, 1]
  loop do
    value = fib[-1] + fib[-2]
    break if value >= max_value

    fib << value
  end
  fib
end

puts fibonachi(100)
puts fibonachi(100)[10]

def fibonachi_of(numbers)
  fib = [0, 1]
  (2..numbers - 1).each { fib << fib[-1] + fib[-2] }
  fib
end

puts fibonachi_of(10)

puts fibonachi_of(10)[10]
