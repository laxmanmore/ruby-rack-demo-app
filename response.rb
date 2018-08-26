# This class is responsible for returning response to request
class Response
  def initialize(request)
    @request = request
    @response = Rack::Response.new
  end

  def respond_to_request
    if @request.get?
      # @response will set default status as 200
      case @request.path_info
      when '/search'
        search_users
      when '/users'
        fetch_users
      when %r{/\d+}
        fetch_user
      else
        bad_request
      end
    else
      bad_request
    end
    @response.finish
  end

  def fetch_users
    build(User.all)
  end

  def fetch_user
    id = @request.path_info.split('/').last.to_i
    build(User.find_by_id(id))
  end

  def search_users
    name = Rack::Utils.parse_nested_query(@request.query_string)['name']
    build(User.find_by_name(name))
  end

  def build(data)
    return result_not_found if data.empty?
    @response.write(JSON.generate(data))
  end

  def bad_request
    @response.status = 404
    @response.write(JSON.generate({'message' => 'Bad request'}))
  end

  def result_not_found
    @response.status = 400
    @response.write(JSON.generate({'message' => 'Not found'}))
  end
end
