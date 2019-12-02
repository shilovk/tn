# frozen_string_literal: true

class Sample
  def hello
    puts 'Hello, World!'
  end
end

s = Sample.new
5.times do
  puts s.hello
end

class Student
  attr_accessor :first_name, :last_name, :primary_phone_number

  def introduction(target)
    puts "Hi #{target}, I'm #{first_name}!"
  end

  def favorite_number
    7
  end
end

student = Student.new
puts 'What is your name?'
student.first_name = gets.chomp
student.introduction('Katrina')
puts student.favorite_number
