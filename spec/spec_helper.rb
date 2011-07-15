require 'quimby'
require 'vcr'
require 'support/vcr_setup'
require 'yaml'

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

ENVIRONMENT = ENV["FSQ_ENV"] || "production"
CONFIG_PATH = File.join(File.dirname(__FILE__), "..")
CONFIG_NAME = "config.yml"
CONFIG_FILE = File.join(CONFIG_PATH, CONFIG_NAME)
APPCONFIG = YAML.load_file(CONFIG_FILE)[ENVIRONMENT.to_sym]

def rrand(x)
  rand(2*x) - x
end

