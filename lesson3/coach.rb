# frozen_string_literal: true

require_relative 'company_name'
require_relative 'show'

# Coach
class Coach
  include CompanyName
  include Show
  COACH_TYPES = %w[passenger cargo]
  @all = []
  class << self
    attr_reader :all

    protected

    attr_writer :all
  end
  attr_reader :type, :size, :free

  def initialize(size)
    @size = size.to_i
    @free = @size
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
end

# PassengerCoach < Coach
class PassengerCoach < Coach
  def initialize(size)
    @type = COACH_TYPES.index('passenger')
    super(size)
  end

  def size_set(value = 0)
    super(value)
  end
end

# CargoCoach < Train
class CargoCoach < Coach
  def initialize(size)
    @type = COACH_TYPES.index('cargo')
    super(size)
  end

  def size_set(value = 1)
    super(value)
  end
end
