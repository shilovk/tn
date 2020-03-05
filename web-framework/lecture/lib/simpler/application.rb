require 'singleton'

module Simpler
  class Application
    include Singleton

    def call(env)
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Simpler fraimwork in action!\n"]
      ]
    end
  end
end

# p Simpler::Application.respond_to?(:new)
# p Simpler::Application.instance.object_id
# p Simpler::Application.instance.object_id
