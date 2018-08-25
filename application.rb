app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require(file) }
require 'json'

class Application
  def call(env)
    # request = Rack::Request.new(env)
    response = Rack::Response.new
    response.headers['Content-Type'] = 'application/json'
    puts env['PATH_INFO']
    if env['PATH_INFO'] == '/' || env['PATH_INFO'] == '/users'
      # response.status = 200 #no need to set, bec default is 200
      response.write(JSON.generate(Database.users))
    elsif env['PATH_INFO'] =~ %r{/\d+}
      id = env['PATH_INFO'].split('/').last.to_i
      response.write(JSON.generate(Database.users[id]))
    else
      response.status = 404
      response.write('Not found')
    end
    response.finish
  end
end
