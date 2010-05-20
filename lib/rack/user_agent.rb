require 'rack'

module Rack::UserAgent
  VERSION = "0.1.1"
  autoload :Filter, 'rack/user_agent/filter'  
end