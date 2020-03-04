require_relative 'middleware/runtime'
require_relative 'app'

use Runtime
run App.new

# rackup
# curl --url "http://localhost:9292/" -i
