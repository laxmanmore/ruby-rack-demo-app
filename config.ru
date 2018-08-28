require './application'
require 'rack/cache'

use Rack::Reloader, 0

use Rack::ContentType, 'application/json'

use Rack::Cache
use Rack::ConditionalGet
use Rack::ETag

use Rack::Auth::Basic do |username, password|
  username == 'test' && password == 'test'
end

run Application.new
