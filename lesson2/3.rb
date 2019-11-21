# 3. Заполнить массив числами фибоначчи до 100 

def fibonachi(max_value)
  fib = [0, 1]
  n = 2
  loop do
    value = fib[n-1] + fib[n-2]
    break if value >= max_value
    fib[n] = value
    n += 1
  end
  fib
end

puts fibonachi(100)
