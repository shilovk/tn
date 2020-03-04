require 'byebug'
require_relative 'modules/settings'
require_relative 'classes/format_time'
require_relative 'middleware/request_path'
require_relative 'app'

use RequestPath
run App.new

# rackup
# curl --url "http://localhost:9292/time?format=year%2Cmonth%2Cday%2Cminute" -i
