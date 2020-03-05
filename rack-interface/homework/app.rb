class App
  def call(_env, text)
    @text = text

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
    ["#{@text}\n"]
  end
end
