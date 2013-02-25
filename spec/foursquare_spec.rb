require "spec_helper"

describe Foursquare do

  # describe "associating venues and specials" do
  # 
  # end

  describe "#configuration" do
    it "returns a Foursquare::Configuration object" do
      Foursquare.configuration.class.should == Foursquare::Configuration
    end
  end

  describe "#configure" do
    before do
      Foursquare.configure do |config|
        Foursquare::Configuration.valid_option_keys.each do |key|
          config.send("#{key}=", "#{key}1111")
        end
      end
    end

    Foursquare::Configuration.valid_option_keys.each do |key|
      it "sets the #{key} to the passed in value" do
        Foursquare.configuration.send(key).should == "#{key}1111"
      end
    end
  end

  describe "#env" do
    it "exposes the environment string via an instance method" do
      Foursquare.env.should be_true
    end

    it "defaults to production" do
      Foursquare.env.should eq("production")
    end

    it "can be reassigned" do
      Foursquare.env = "staging"
      Foursquare.env.should eq("staging")
    end
  end

  # describe "delegation to a client" do
  #   it "returns the correct resource for venues" do
  #     Typhoeus.should_receive(:get).with("/venues/12345")
  #     Foursquare.venues["12345"]
  #   end

  #   it "returns the same results as a client" do
  #     client_result = Foursquare::Client.new.venues["12345"]
  #     Foursquare.venues["12345"].should == client_result
  #   end
  # end
end
