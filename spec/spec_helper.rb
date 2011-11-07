require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'quimby' 

RSpec.configure do |config|


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