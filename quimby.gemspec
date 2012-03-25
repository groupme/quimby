# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{quimby}
  s.version = "0.5.1"
  s.description = %q{Foursquare API Wrapper}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Nakajima", "Mark Nyon", "Marcus Smith"]
  s.date = %q{2011-01-14}
  s.email = %q{pat@groupme.com mark@grandkru.com marcus@location.st}
  s.files = [
    "README.md",
    "lib/foursquare.rb",
    "lib/quimby.rb",
    "lib/foursquare/base.rb",
    "lib/foursquare/category.rb",
    "lib/foursquare/checkin.rb",
    "lib/foursquare/checkin_proxy.rb",
    "lib/foursquare/comment.rb",
    "lib/foursquare/explore_item.rb",
    "lib/foursquare/explore_result.rb",
    "lib/foursquare/icon.rb",
    "lib/foursquare/list.rb",
    "lib/foursquare/list_proxy.rb",
    "lib/foursquare/location.rb",
    "lib/foursquare/multi.rb",
    "lib/foursquare/photo.rb",
    "lib/foursquare/photo_proxy.rb",
    "lib/foursquare/settings.rb",
    "lib/foursquare/tip.rb",
    "lib/foursquare/tip_proxy.rb",
    "lib/foursquare/user.rb",
    "lib/foursquare/user_proxy.rb",
    "lib/foursquare/venue.rb",
    "lib/foursquare/venue_proxy.rb",
    "lib/foursquare/venue_stats.rb",
    "LICENSE",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{https://github.com/groupme/quimby}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Foursquare API wrapper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])   
      s.add_runtime_dependency(%q<hashie>, [">=0"])  
      s.add_runtime_dependency(%q<multipart-post>, [">=0"])  
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<ZenTest>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<hashie>, [">=0"])
      s.add_dependency(%q<multipart-post>, [">=0"])  
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<ZenTest>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<hashie>, [">=0"])    
    s.add_dependency(%q<multipart-post>, [">=0"])  
    s.add_development_dependency(%q<rspec>, [">= 0"])
    s.add_development_dependency(%q<ZenTest>, [">= 0"])
  end
end
