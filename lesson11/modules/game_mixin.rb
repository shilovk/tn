# frozen_string_literal: true

# GameMixin
module GameMixin
  STEPS = { 'next' => 'next step', 'taking' => 'take card', 'opening' => 'open cards' }.freeze

  def self.included(base)
    base.extend ClassMethods
  end

  # ClassMethods
  module ClassMethods
    def steps
      @steps
    end

    def define_steps(args = {})
      @steps = GameMixin::STEPS.keys
      @steps.delete(args[:delete])
    end
  end
end
