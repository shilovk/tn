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
