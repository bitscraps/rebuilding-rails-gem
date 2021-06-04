require "rulers/version"
require "rulers/array"
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'

module Rulers
  class Error < StandardError; end
  
  class Application
    def call(env)
      if env['PATH_INFO'] == 'favicon.ico'
        return [404, { 'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        if File.exists?("public/index.html")
          return [200, { 'Content-Type' => 'text/html'},
            [File.read("public/index.html")]]
        else
          return [200, { 'Content-Type' => 'text/html'},
          [HomeController.new(env).index]]
        end
      end

      begin
        klass, action = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(action)
        [200, { 'Content-Type' => 'text/html'},
          [text]]
      rescue => e
        if env['environment'] == 'production'
          [500, { 'Content-Type' => 'text/html'}, ["Something went wrong"]]
        else
          raise
        end
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
