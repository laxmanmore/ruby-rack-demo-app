require './response'
require './user'
require 'json'

class Application
  def call(env)
    res = Response.new(Rack::Request.new(env))
    res.respond_to_request
  end
end
