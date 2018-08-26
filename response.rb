class Response
	def initialize(request)
		@request = request
		@response = Rack::Response.new
	end

	def respond_to_request
    if @request.get? && @request.path_info == '/users'
      # @response will set default status as 200
      fetch_users
    elsif @request.get? && @request.path_info =~ %r{/\d+}
      id = @request.path_info.split('/').last.to_i
      fetch_user(id)
    else
      bad_request
    end
	  @response.finish
  end

  def fetch_users
    build(User.all)
  end

  def fetch_user(id)
    build(User.find_by_id(id))
  end

  def build(data)
    return result_not_found unless data
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
