require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'quimby' 

RSpec.configure do |config|
end

def foursquare
  # https://foursquare.com/user/17409817
  @foursquare ||= Foursquare::Base.new(nil)
end

def current_user
  return @current_user if @current_user
  foursquare.stub(:get).with("users/self").and_return(JSON.parse(get_file("spec/fixtures/users/self.json")))
  foursquare.users.find "self"
end

def get_file(path)
  File.open(path, "rb") do | file |
    file.read
  end
end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end