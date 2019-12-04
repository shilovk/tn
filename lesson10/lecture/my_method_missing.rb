# frozen_string_literal: true

# Define for method_missing
class MyClass
  def method_missing(name, *args)
    self.class.send(:define_method, name.to_sym, -> { p args })
  rescue
    super
  end

  def respond_to_missing?(_name, _include_private)
    super
  end
end

my_obj = MyClass.new
p my_obj.public_methods # ..., :method_missing, ...
p my_obj.new_method 1, 2, 3, 4 # [1, 2, 3, 4]
p my_obj.respond_to? :new_method # true
p my_obj.method :new_method # #<Method: MyClass#new_method>
puts 1
p my_obj.public_methods # ..., :new_method, :method_missing, ...
p my_obj.new_method # []
p my_obj.respond_to? :new_method2 # There is no method new_method2
p my_obj.method :new_method2 # Undefined method `new_method2' for class `MyClass'

class MyClass2
  def respond_to_missing?(_name, _include_private)
    true
  end
end

my_obj2 = MyClass.new
p my_obj2.respond_to? :new_method2 # #<Method: MyClass2#new_method2>
p my_obj2.method :new_method2 # #<Method: MyClass2#new_method2>

require 'ostruct'

class Order
  def user
    @user ||= OpenStruct.new(name: 'Mike', age: 28, occupation: 'slacker')
  end

  def method_missing(method_name, *arguments, &block)
    if method_name.to_s =~ /user_(.*)/
      user.send($1, *arguments, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('user_') || super
  end
end

p order = Order.new
p order.respond_to?(:user_not_method) # #<Method: Order#user_not_method>
p order.method(:user_not_method) # #<Method: Order#user_not_method>

# For hash
class Hash
  def method_missing(name)
    self[name.to_sym] || self[name.to_s] || super
  end

  def respond_to_missing?(_name, _include_private)
    super
  end
end

hash = {a: 2, "b": 1, c: 0.5}
p hash.a # 2
p hash.b # 1