require "spec_helper"

describe Foursquare::Configuration do
  describe "valid options" do
    it "exposes a list of valid option keys" do
      keys = [:endpoint,
              :http_username,
              :http_password,
              :oauth_token,
              :oauth_consumer_key,
              :oauth_consumer_secret]

      Foursquare::Configuration.valid_option_keys.should eq(keys)
    end
  end

  describe "defaults" do
    it "sets the endpoint to the correct default" do
      url = "https://api.foursquare.com/v2/"
      config = Foursquare::Configuration.new
      config.endpoint.should eq(url)
    end

    Foursquare::Configuration.valid_option_keys.reject do |key|
      key == :endpoint
    end.each do |key|
      it "defaults #{key} to nil" do
        Foursquare::Configuration::DEFAULTS[key].should be_nil
      end
    end
  end

  describe "initialization of options from a config file" do
    it "initializes the endpoint to the value in the config" do
      url = APPCONFIG[:api][:endpoint]
      Foursquare::Configuration.new.endpoint.should eq(url)
    end

    it "initializes the http_username to the value in the config" do
      username = APPCONFIG[:auth][:http_username]
      Foursquare::Configuration.new.http_username.should eq(username)
    end

    it "initializes the http_password to the value in the config" do
      password = APPCONFIG[:auth][:http_password]
      Foursquare::Configuration.new.http_password.should eq(password)
    end

    it "initializes the oauth_token to the value in the config" do 
      oauth_token = APPCONFIG[:auth][:oauth_token]
      Foursquare::Configuration.new.oauth_token.should eq(oauth_token)
    end

    it "initializes the oauth_consumer_key to the value in the config" do 
      oauth_consumer_key = APPCONFIG[:auth][:oauth_consumer_key]
      Foursquare::Configuration.new.oauth_consumer_key.should eq(oauth_consumer_key)
    end

    it "initializes the oauth_consumer_secret to the value in the config" do 
      oauth_consumer_secret = APPCONFIG[:auth][:oauth_consumer_secret]
      Foursquare::Configuration.new.oauth_consumer_secret.should eq(oauth_consumer_secret)
    end
  end

  describe "initialization of a new config" do
    Foursquare::Configuration.valid_option_keys.each do |key|
      it "initializes #{key} to the passed in value" do
        fsq = Foursquare::Configuration.new(key => "test")
        fsq.send("#{key}").should eq("test")
      end
    end
  end
end
