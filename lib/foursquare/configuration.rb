require "foursquare/version"

module Foursquare
  class Configuration
    DEFAULTS = {}
    VALID_OPTION_KEYS = [:endpoint,
                         :http_username,
                         :http_password,
                         :oauth_token,
                         :oauth_consumer_key,
                         :oauth_consumer_secret].freeze

    # Most options default to nil
    VALID_OPTION_KEYS.each {|key| DEFAULTS[key] = nil}

    # Override nil options here
    DEFAULTS[:endpoint] = "https://api.foursquare.com/v2/"
    DEFAULTS.freeze

    VALID_OPTION_KEYS.each {|k| attr_accessor k}

    def initialize(options={})
      VALID_OPTION_KEYS.each do |key|
        option = options.delete(key) || DEFAULTS[key]
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
