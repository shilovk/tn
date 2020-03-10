class TestsController < Simpler::Controller
  def index

  end

  def create

  end
end

# p self.class # => object

# DB = Class.new
# p DB.class # => Class
# p DB.superclass # => Object
#
# DB = Class.new do
#   def connect
#     'Connected to the database'
#   end
# end
# p DB.new.connect # => Connected to the database
