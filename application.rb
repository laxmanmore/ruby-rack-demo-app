app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require(file) }
require 'json'

class Application
  def call(env)
    request = Rack::Request.new(env)
    if request.get?
      respond_to_request(request)
    else
      [400, {}, ['Bad Request']]
    end
  end

  def respond_to_request(request)
    response = Rack::Response.new
    if request.path_info == '/' || request.path_info == '/users'
      # response.status = 200 #no need to set, bec default is 200
      get_all_users(response)
    elsif request.path_info =~ %r{/\d+}
      get_single_user(request, response)
    else
      missing(response)
    end
    response.finish
  end

  def get_all_users(response)
    response.write(JSON.generate(Database.users))
  end

  def get_single_user(request, response)
    id = request.path_info.split('/').last.to_i
    user = Database.users[id]
    return not_found(response) unless user
    response.write(JSON.generate(user))
  end

  def missing(response)
    response.status = 404
    response.write(JSON.generate({'message' => 'Bad request'}))
  end

  def not_found(response)
    response.status = 400
    response.write(JSON.generate({'message' => 'Not found'}))
  end
end
