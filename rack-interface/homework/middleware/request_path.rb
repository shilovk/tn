class RequestPath
  def initialize(app)
    @app = app
  end

  def call(env)
    return [status, headers, body] if env['REQUEST_PATH'] != Settings::ALLOW_PATH

    status, headers, body = @app.call(env)

    [status, headers, body]
  end

  private

  def status
    404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    []
  end
end
