require 'spec_helper'

describe "Foursquare::Client" do
  let(:auth_params) do 
    {username: APPCONFIG[:auth][:username], 
     password: APPCONFIG[:auth][:password],
     auth_type: APPCONFIG[:auth][:type]}
  end

  it "takes a username and password" do
    VCR.use_cassette('denver_zoo') do
      url = "https://api.foursquare.com/v2"
      @four = Foursquare::Client.new(:auth => auth_params, :url => url)
      @denver_zoo = @four.venues.find('118057')
      @denver_zoo.url.should == 'http://www.denverzoo.org'
    end
  end

  describe "#valid_date_string" do
    it "returns a string with the current YYYYMMDD" do
      valid_date_string = Time.new.strftime("%Y%m%d")
      @four = Foursquare::Client.new(:auth => auth_params)
      @four.send(:valid_date_string).should == valid_date_string
    end
  end
end

