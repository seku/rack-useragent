require 'user_agent'
require 'erb'
require 'tilt'
require 'ostruct'

module Rack
  module UserAgent
    class Filter
      
      def initialize(app, required_browsers = [], options = {})
        @app                = app
        @browsers           = required_browsers.map{ |b| OpenStruct.new(:browser => b[0], :version => b[1]) }
        @template           = options[:template]
        @force_with_cookie  = options[:force_with_cookie]
      end

      def call(env)
        request = Rack::Request.new(env)
        useragent = ::UserAgent.parse(env["HTTP_USER_AGENT"].to_s)
        if useragent.any? && !detection_disabled_by_cookie?(request.cookies) && unsupported?(useragent)
          content = render_page(useragent)
          [400, {"Content-Type" => "text/html", "Content-Length" => content.length.to_s}, content]
        else
          @app.call(env)
        end
      end

      private

      def unsupported?(useragent)
        useragent && @browsers.detect { |browser| useragent < browser }
      end

      def detection_disabled_by_cookie?(cookies)
        @force_with_cookie && cookies.keys.include?(@force_with_cookie)
      end

      def render_page(useragent)
        if @template && ::File.exists?(@template)
          @browser = useragent # for the template
          Tilt.new(@template).render(self)
        else
          "Sorry, your browser is not supported. Please upgrade" 
        end
      end
    end

  end
end
