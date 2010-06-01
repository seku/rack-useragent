require 'user_agent'
require 'erb'
require 'ostruct'

module Rack::UserAgent
  class Filter
    def initialize(app, browsers = [], options = {})
      @app                = app
      @browsers           = browsers
      @template           = options[:template]
      @force_with_cookie  = options[:force_with_cookie]
    end
    
    def call(env)
      request = Rack::Request.new(env)
      browser = UserAgent.parse(env["HTTP_USER_AGENT"]) if env["HTTP_USER_AGENT"]
      if !detection_disabled_by_cookie?(request.cookies) && unsupported?(browser)
        content = render_page(browser)
        [400, {"Content-Type" => "text/html", "Content-Length" => content.length.to_s}, content]
      else
        @app.call(env)
      end
    end
    
    private
    
    def unsupported?(browser)
      browser && @browsers.map{ |hash| browser < OpenStruct.new(hash) }.any?
    end

    def detection_disabled_by_cookie?(cookies)
      @force_with_cookie && cookies.keys.include?(@force_with_cookie)
    end
    
    def render_page(browser)
      if @template && File.exists?(@template)
        @browser = browser # for the template
        ERB.new(File.read(@template)).result(binding)
      else
        "Sorry, your browser is not supported. Please upgrade" 
      end
    end

  end
end
