# frozen_string_literal: true

# MyAttrAccessor
module MyAttrAccessor
  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr, :a, :b, :c
end

p test = Test.new # <Test:0x00007f91cb96cc60>
p test.my_attr # nil
p test.my_attr = 5 # 5
p test.my_attr # 5
p test.instance_variables # @my_attr
