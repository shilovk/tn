# frozen_string_literal: true

# ClassInstances
module ClassInstances
  def self.included(base)
    base.extend ClassMethods
  end

  # ClassMethods
  module ClassMethods
    def class_attr_accessor_with_history(name)
      var_name = "@#{name}".to_sym
      define_singleton_method(name.to_sym) do
        class_eval(var_name.to_s) || instance_variable_set(var_name, [])
      end
      define_singleton_method("#{name}=".to_sym) do |value|
        values = [instance_variable_get(var_name), value].flatten.compact
        instance_variable_set(var_name, values)
      end
    end
  end
end
