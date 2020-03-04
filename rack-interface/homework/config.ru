require_relative 'app'

run App.new

# rackup
# curl --url "http://localhost:9292/time?format=year%2Cmonth%2Cday%2Cminute" -i
