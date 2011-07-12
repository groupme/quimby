require 'spec_helper'

describe Foursquare do
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
end
