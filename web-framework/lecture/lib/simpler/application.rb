require 'yaml'
require 'singleton'
require 'sequel'
require_relative 'router'
require_relative 'controller'

module Simpler
  class Application
    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new
      @db = nil
    end

    def bootstrap!
      setup_database
      require_app
      require_routes
    end

    def call(env)
      route = @router.route_for(env)
      controller = route.controller.new(env)
      action = route.action
      make_response(controller, action)
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    private

    def setup_database
      database_config = YAML.load_file(Simpler.root.join('config/database.yml'))
      database_config['database'] = Simpler.root.join(database_config['database'])

      @db = Sequel.connect(database_config)
      seed
    end

    def require_app
      Dir["#{Simpler.root}/app/**/**.rb"].sort.each { |file| require file }
    end

    def require_routes
      require Simpler.root.join('config/routes')
    end

    def make_response(controller, action)
      controller.make_response(action)
    end

    def seed
      @db.create_table(:tests) do
        primary_key :id
        String :title, null: false
        Integer :level, default: 0
      end
      @db[:tests].insert(title: 'Ruby Beginner', level: 0)
      @db[:tests].insert(title: 'Ruby Advanced', level: 1)
      @db[:tests].insert(title: 'Ruby Expert', level: 2)
      @db[:tests].insert(title: 'JavaScript Basic', level: 3)
    end
  end
end

# p Simpler::Application.respond_to?(:new)
# p Simpler::Application.instance.object_id
# p Simpler::Application.instance.object_id

# irb
# require_relative 'config/environment'
# Simpler.application
# Simpler.application.db
# Simpler.application.db.create_table(:tests) do
#   primary_key :id
#   String :title, null: false
#   Integer :level, default: 0
# end
# Simpler.application.db[:tests].all #=> []
#
# Simpler.application.db[:tests].insert(title: 'Ruby Beginner', level: 0)
# Simpler.application.db[:tests].insert(title: 'Ruby Advanced', level: 1)
# Simpler.application.db[:tests].insert(title: 'Ruby Expert', level: 2)
# Simpler.application.db[:tests].insert(title: 'JavaScript Basic', level: 3)
# Simpler.application.db[:tests].all
# Simpler.application.db[:tests].all[0]
# Simpler.application.db[:tests].where(level: 1)
# Simpler.application.db[:tests].where(level: 1).all
# Simpler.application.db[:tests].where { level >= 2 }
