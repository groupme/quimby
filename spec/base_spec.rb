require 'spec_helper'

describe "base" do
  it "defines url on the returned json object for a venue" do
    VCR.use_cassette('denver_zoo') do
      oauth_key = APPCONFIG[:auth][:oauth_consumer_key]
      oauth_secret = APPCONFIG[:auth][:oauth_consumer_secret]
      @four = Foursquare::Base.new(oauth_key, oauth_secret)
      @denver_zoo = @four.venues.find('118057')
      @denver_zoo.url.should == 'http://www.denverzoo.org'
    end
  end
end
