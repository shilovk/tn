# frozen_string_literal: true

# InstanceCounter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # ClassMethods
  module ClassMethods
    attr_accessor :instances
  end

  # InstanceMethods
  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
