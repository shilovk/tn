# frozen_string_literal: true

# CardsGenerate
module CardsGenerate
  TYPES =  %w[♠ ♥ ♣ ♦].freeze
  NAMES =  %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 10]].freeze

  module_function

  def cards
    TYPES.each_with_object([]) do |type, memo|
      NAMES.each { |name| memo << "#{name}#{type}" }
    end
  end

  def cards_values
    TYPES.each_with_object({}) do |type, memo| 
      NAMES.each_with_index { |name, i| memo["#{name}#{type}"] = VALUES[i] }
    end
  end
end
