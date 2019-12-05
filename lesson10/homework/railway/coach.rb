# frozen_string_literal: true

require_relative 'modules/validation'
require_relative 'modules/company_name'
require_relative 'modules/show'

# Coach
class Coach
  include Validation
  include CompanyName
  include Show

  COACH_TYPES = %w[passenger cargo].freeze

  @all = []
  @proc_show_template = proc do |el, i|
    puts "Coach: #{i + 1} #{Coach::COACH_TYPES[el.type]} #{el.free} #{el.busy}"
  end
  class << self
    attr_reader :all, :proc_show_template

    protected

    attr_writer :all
  end

  attr_reader :type, :size, :free

  validate :size, :presence
  validate :size, :type, Integer

  def initialize(size)
    @size = size.to_i
    @free = @size
    validate!
    Coach.all << self
  end

  def of_type?(checking_type)
    @type == checking_type
  end

  def size_set(value = 0)
    size_new = free - value.to_i
    raise 'Not enough space!' if size_new.negative?

    self.free = size_new
  end

  def busy
    size - free
  end

  protected

  attr_writer :free

  def validate!
    raise 'Size is not be 0' if size.zero?
  end
end
