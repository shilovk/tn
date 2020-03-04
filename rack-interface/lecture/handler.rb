require 'rack'
require 'rack/handler/puma'

app = proc do |_env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    ["Welcome aboard!\n"]
  ]
end

Rack::Handler::Puma.run app

# ruby hander.rb
# curl --url "http://localhost:8080/" -i
