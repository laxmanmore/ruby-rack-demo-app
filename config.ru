require './application'
require './database'

use Rack::Reloader, 0

use Rack::Auth::Basic do |username, password|
  username == 'test' && password == 'test'
end
run Application.new
