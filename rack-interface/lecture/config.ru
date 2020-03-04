require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'app'

use Runtime
use AppLogger
run App.new

# rackup
# curl --url "http://localhost:9292/" -i
