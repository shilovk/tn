# frozen_string_literal: true

require 'pry'
require_relative 'accessors'
require_relative 'validation'

# MyClass
class MyClass
  extend Accessors
  include Validation

  attr_accessor_with_history :name1, :name2, :name3

  strong_attr_accessor :my_string, String
  strong_attr_accessor :my_fixnum, Integer

  attr_accessor :val1, :val2, :val3
  validate :val1, :presence
  validate :val1, :type, String
  validate :val1, :format, /A-Z{0,3}/
  validate :val2, :format, /A-Z{0,3}/
  validate :val3, :type, String
end

my_obj = MyClass.new
my_obj.name1 = 1
p my_obj.instance_variables
p my_obj.name1
my_obj.name1 = 2
p my_obj.name1
p my_obj.public_methods(false)
p my_obj.class.instance_methods(false)
p my_obj.name1_history
my_obj.my_string = 'Abc'
my_obj.my_string = 123
p my_obj.my_string
my_obj.my_fixnum = 123
p my_obj.my_fixnum
my_obj.my_fixnum = 'Abc'
p my_obj.my_fixnum

my_obj.val1 = 'A-Z'
my_obj.val2 = 'A-Z'
my_obj.val3 = '1'
my_obj.valid?
