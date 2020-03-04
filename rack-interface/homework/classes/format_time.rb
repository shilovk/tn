class FormatTime
  def initialize(format_string)
    parse_string(format_string)
  end

  def valid?
    correct_formats.any? && bad_formats.empty?
  end

  def time
    correct_formats.map { |value| DateTime.now.send(value) }.join('-')
  end

  def invalid_formats
    "Unknown time format [#{bad_formats.join(', ')}]"
  end

  private

  def parse_string(format_string)
    @parsed_string = Rack::Utils.parse_nested_query(format_string)[Settings::ALLOW_PARAM]
  end

  def formats
    @formats = @parsed_string.nil? ? [] : @parsed_string.split(',')
  end

  def correct_formats
    @correct_formats = Settings::ALLOW_VALUES.select { |value| formats.include? value }
  end

  def bad_formats
    @bad_formats = formats - correct_formats
  end
end
