# frozen_string_literal: true

# Steps
module Steps
  STEPS = %w[next taking opening].freeze

  def self.included(base)
    base.extend ClassMethods
  end

  # ClassMethods
  module ClassMethods
    def steps
      @steps
    end

    def define_steps(args = {})
      @steps = [Steps::STEPS].flatten
      @steps.delete(args[:delete])
    end
  end
end
