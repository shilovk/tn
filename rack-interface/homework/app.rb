class App
  def call(_env, formatter)
    @formatter = formatter

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
    ["#{@formatter.output}\n"]
  end
end
