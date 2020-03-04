class RequestPath
  def initialize(app)
    @app = app
  end

  def call(env)
    return [404, { 'Content-Type' => 'text/plain' }, []] if env['REQUEST_PATH'] != ALLOW_PATH

    status, headers, body = @app.call(env)

    [status, headers, body]
  end
end
