require "spec_helper"

describe Foursquare::Configuration do
  describe "options" do
    keys = [:endpoint,
            :http_username,
            :http_password,
            :oauth_token,
            :oauth_consumer_key,
            :oauth_consumer_secret]
    Foursquare::Configuration.valid_option_keys.should == keys
  end

  describe "defaults" do
    it "sets the endpoint to the correct default" do
      url = "https://api.foursquare.com/v2/"
      config = Foursquare::Configuration.new
      config.endpoint.should == url
    end

    Foursquare::Configuration.valid_option_keys.reject do |key|
      key == :endpoint
    end.each do |key|
      it "defaults #{key} to nil" do
        Foursquare::Configuration.new.send("#{key}").should be_nil
      end
    end
  end

  describe "initialization of a new config" do
    Foursquare::Configuration.valid_option_keys.each do |key|
      it "initializes #{key} to the passed in value" do
        fsq = Foursquare::Configuration.new(key => "test")
        fsq.send("#{key}").should == "test"
      end
    end
  end
end
