# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{quimby}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Nakajima"]
  s.date = %q{2011-01-14}
  s.email = %q{pat@groupme.com}
  s.files = [
    "README.md",
    "lib/foursquare.rb",
    "lib/foursquare/base.rb",
    "lib/foursquare/settings.rb",
    "lib/foursquare/tip.rb",
    "lib/foursquare/multi.rb",
    "lib/foursquare/checkin.rb",
    "lib/foursquare/photo.rb",
    "lib/foursquare/checkin_proxy.rb",
    "lib/foursquare/user.rb",
    "lib/foursquare/user_proxy.rb",
    "lib/foursquare/venue.rb",
    "lib/foursquare/venue_proxy.rb",
    "spec/THERE_ARENT_ANY",
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
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
