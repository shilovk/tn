require 'time'

puts 'What is you name?'
name = gets.chomp
puts 'How old are you?'
year = gets.to_i
puts "Your name is #{name}. Hello! Your are #{Time.now.year - year} years old."
