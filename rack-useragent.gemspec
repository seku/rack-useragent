# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-useragent}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio Gil", "Luismi Cavall\303\251"]
  s.date = %q{2009-05-22}
  s.email = %q{ballsbreaking@bebanjo.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "VERSION",
     "lib/rack/user_agent.rb",
     "lib/rack/user_agent/filter.rb",
     "rack-useragent.gemspec",
     "test/public/upgrade.es.html",
     "test/public/upgrade.html",
     "test/upgrade.erb",
     "test/user_agent_filter_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bebanjo/rack-useragent}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rack Middleware for filtering by user agent}
  s.test_files = [
    "test/user_agent_filter_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<josh-useragent>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0.9.1"])
      s.add_dependency(%q<josh-useragent>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0.9.1"])
    s.add_dependency(%q<josh-useragent>, [">= 0"])
  end
end
