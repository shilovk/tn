class App
  def call(env)
    @formatter = FormatTime.new(env['QUERY_STRING'])
    [status, headers, body]
  end

  private

  def status
    @formatter.valid? ? 200 : 400
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{response_body}\n"]
  end

  def response_body
    @formatter.valid? ? @formatter.time : @formatter.invalid_formats
  end
end
