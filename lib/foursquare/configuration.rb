require "foursquare/version"

module Foursquare
  class Configuration
    # Load the configuration file
    CONFIG_FILE = YAML.load_file('config.yml')

    # Define keys that will be valid for passing in options
    VALID_OPTION_KEYS = [:endpoint,
                         :http_username,
                         :http_password,
                         :oauth_token,
                         :oauth_consumer_key,
                         :oauth_consumer_secret].freeze

    # Generate accessors for configuration options
    VALID_OPTION_KEYS.each {|k| attr_accessor k}

    # Define a container for defaults
    DEFAULTS = {}

    # Initialize defaults to nil
    VALID_OPTION_KEYS.each {|key| DEFAULTS[key] = nil}

    # Override nil options here
    DEFAULTS[:endpoint] = "https://api.foursquare.com/v2/"

    # Prevent further modifications to defaults
    DEFAULTS.freeze

    def initialize(options={})
      # Read in options from config file
      env_sym = Foursquare.env.to_sym
      config_file_hash = CONFIG_FILE[env_sym]
      config_file_opts = {}
      
      # HACK because config file layout and
      # config object structure are not identical
      config_file_hash[:api].each do |key, val|
        config_file_opts[key] = val
      end
      config_file_hash[:auth].each do |key, val|
        config_file_opts[key] = val
      end

      # Initialize values 
      # (is there a way to do this en masse, instead of iterating?)
      VALID_OPTION_KEYS.each do |key|
        option = options.delete(key) || 
          config_file_opts[key] || 
          DEFAULTS[key]
        self.send("#{key}=", option)
      end
    end

    # Expose VALID_OPTION_KEYS as a class method
    def self.valid_option_keys
      VALID_OPTION_KEYS
    end
    
    # Initialize options to defaults when this module is extended
    def self.extended(base)
      base.reset
    end

    def configure
      yield configuration if block_given?
    end

    def configuration
      options = {}
      VALID_OPTION_KEYS.each {|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to their default values
    def reset
      self.send("endpoint=", DEFAULTS[:endpoint])
    end
  end
end
