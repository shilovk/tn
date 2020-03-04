class RequestParams
  def initialize(app)
    @app = app
  end

  def call(env)
    @formatter = FormatTime.new(env['QUERY_STRING'])

    return [status, headers, body] unless @formatter.valid?

    status, headers, body = @app.call(env)

    [status, headers, body]
  end

  private

  def status
    400
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{@formatter.invalid_formats}\n"]
  end
end
