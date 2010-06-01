require "rubygems"
require "rack/test"
require "shoulda"

require File.dirname(__FILE__) + '/../lib/rack/user_agent'

class SampleApp
  def call(env)
    [200, {}, "Sample Response"]
  end
end