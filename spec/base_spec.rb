require 'spec_helper'

describe "base" do
  it "defines url on the returned json object for a venue" do
    VCR.use_cassette('denver_zoo') do
      @four = Foursquare::Base.new(APPCONFIG[:user][:client_id], APPCONFIG[:user][:client_secret])
      @denver_zoo = @four.venues.find('118057')
      @denver_zoo.url.should == 'http://www.denverzoo.org'
    end
  end
end
