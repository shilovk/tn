require 'rack'
require 'rack/utils'

class App
  ALLOW_PATH = '/time'.freeze
  ALLOW_PARAM = 'format'.freeze
  ALLOW_VALUES = %w[year month day hour minute second].freeze

  def call(env)
    @request_path = env['REQUEST_PATH']
    @query_string = env['QUERY_STRING']
    [status, headers, body]
  end

  private

  def status
    request_correct? ? 200 : 400
  end

  def request_correct?
    request_path_correct? && bad_query_values.empty?
  end

  def request_path_correct?
    @request_path_correct = @request_path == ALLOW_PATH
  end

  def correct_query_values
    @correct_query_values = ALLOW_VALUES.select { |value| @query_values.include? value }
  end

  def bad_query_values
    @bad_query_values = query_values - correct_query_values
  end

  def query_values
    @query_string_values = Rack::Utils.parse_nested_query(@query_string)[ALLOW_PARAM]

    return [] if @query_string_values.nil?

    @query_values = @query_string_values.split(',')
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{body_text}\n"]
  end

  def body_text
    request_correct? ? parse_time(DateTime.now) : print_what_wrong
  end

  def parse_time(time_now)
    @correct_query_values.map { |value| time_now.send(value) }.join('-')
  end

  def print_what_wrong
    return '' unless request_path_correct?

    "Unknown time format [#{bad_query_values.join(', ')}]"
  end
end
