class RequestPath
  def initialize(app)
    @app = app
  end

  def call(env)
    return bad_request_path_answer if env['REQUEST_PATH'] != Settings::ALLOW_PATH

    status, headers, body = @app.call(env)

    [status, headers, body]
  end

  private

  def bad_request_path_answer
    [404, { 'Content-Type' => 'text/plain' }, []]
  end
end
