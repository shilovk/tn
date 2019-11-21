# 3. Заполнить массив числами фибоначчи до 100 

def fibonachi(number)
  fib = [0, 1]
  (2..number).each { |n| fib[n] = fib[n-1] + fib[n-2] }
  fib
end

puts fibonachi(100)
