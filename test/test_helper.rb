require "rubygems"
require "rack/test"
require "shoulda"
require 'webmock/test_unit'

require File.dirname(__FILE__) + '/../lib/rack/useragent/filter'

class SampleApp
  def call(env)
    [200, {}, "Sample Response"]
  end
end