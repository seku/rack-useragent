require File.dirname(__FILE__) + '/test_helper'

class UserAgentFilterTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def setup
    @outdated_browser = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" # IE6
    @modern_browser   = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)"      # IE8
  end
  
  def app
    SampleApp.new
  end
  
  context "default page" do
    
    setup do
      def app
       Rack::Builder.new do
          use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]]
          run SampleApp.new
        end
      end
    end
    should "pass" do
      header "User-Agent", @modern_browser
      get '/'
      assert_equal "Sample Response", last_response.body
    end

    should "filter" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "Sorry, your browser is not supported. Please upgrade", last_response.body
    end
    
  end
  
  context "custom page" do
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :template => File.dirname(__FILE__) + "/fixtures/upgrade.erb"
           run SampleApp.new
         end
      end
    end
    
    should "work" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "Hello, Internet Explorer 6.0!", last_response.body
    end
    
  end
  
  context "custom page (haml)" do
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :template => File.dirname(__FILE__) + "/fixtures/upgrade.haml"
           run SampleApp.new
         end
      end
    end
    
    should "work" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "Hello, Internet Explorer 6.0!\n", last_response.body
    end
    
  end

  context "custom message" do
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :custom_message => "I'm custom"
           run SampleApp.new
         end
      end
    end
    
    should "not work" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "I'm custom", last_response.body
    end
  end

  context "custom page (url as a template)" do
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :template => "http://www.example.com"
           run SampleApp.new
         end
      end
      stub_request(:any, "http://www.example.com").to_return(:body => "test", :status => 200)
    end
    
    should "work" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "test", last_response.body
    end
  end

  context "custom page (with bad url)" do
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :template => "ppp"
           run SampleApp.new
         end
      end
    end
    
    should "not work" do
      header "User-Agent", @outdated_browser
      get '/'
      assert_equal "Sorry, your browser is not supported. Please upgrade", last_response.body
    end
  end  
  
  context "cookie" do
    
    setup do
      def app
        Rack::Builder.new do
           use Rack::UserAgent::Filter, [["Internet Explorer", "7.0"]], :force_with_cookie => "browser"
           run SampleApp.new
         end
      end
    end
    
    should "pass if cookie set" do
      header "User-Agent", @outdated_browser
      set_cookie "browser=Internet Explorer"
      get '/'
      assert_equal "Sample Response", last_response.body
      
      clear_cookies
      get '/'
      assert_equal "Sorry, your browser is not supported. Please upgrade", last_response.body
    end
    
  end
  
end