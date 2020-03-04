ALLOW_PATH = '/time'.freeze
ALLOW_PARAM = 'format'.freeze
ALLOW_VALUES = %w[year month day hour minute second].freeze

require_relative 'middleware/request_path'
require_relative 'app'

use RequestPath
run App.new

# rackup
# curl --url "http://localhost:9292/time?format=year%2Cmonth%2Cday%2Cminute" -i
