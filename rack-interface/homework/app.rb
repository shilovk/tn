class App
  def call(env)
    @formatter = FormatTime.new(env['QUERY_STRING'])

    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{@formatter.time}\n"]
  end
end
