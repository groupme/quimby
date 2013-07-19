require 'spec_helper'

describe Foursquare::VenueProxy do
  
  before(:each) do
    foursquare.stub(:get).with("venues/trending", {:ll => '40.7,-74'}).and_return(JSON.parse(get_file("spec/fixtures/venues/trending/venues.json")))
  end
  
  describe "Proxy Methods" do
    
    it "should not find a venue without a id" do
      lambda { foursquare.venues.find() }.should raise_error(ArgumentError)
    end
    
    it "should search for a venue" do
      foursquare.stub(:get).with("venues/4ab7e57cf964a5205f7b20e3").and_return(JSON.parse(get_file("spec/fixtures/venues/foursquarehq.json")))
      foursquare.venues.find('4ab7e57cf964a5205f7b20e3').id.should eql('4ab7e57cf964a5205f7b20e3')
    end
    
    it "should include a :ll options in order to make a search" do
      lambda { foursquare.venues.search() }.should raise_error(ArgumentError)
    end
    
    it "should search for venues around the user (for checkin)" do
      foursquare.stub(:get).with("venues/search", {:ll => '40.7,-74'}).and_return(JSON.parse(get_file("spec/fixtures/venues/search/venues.json")))
      foursquare.venues.search(:ll => '40.7,-74').first.id.should eql("4eaf053bf5b99d2425f5bfa1")
    end
    
    it "should have a explore method" do
      foursquare.stub(:get).with("venues/explore", {:ll => '40.7,-74'}).and_return(JSON.parse(get_file("spec/fixtures/venues/explore/venues.json")))
      foursquare.venues.explore(:ll => '40.7,-74').class.should eql(Foursquare::ExploreResult)
    end
    
    it "should ask for a location when asking for trending venues" do
      lambda { foursquare.venues.trending() }.should raise_error(ArgumentError)
    end
    
    it "should give 9 trendings venues" do
      foursquare.venues.trending(:ll => '40.7,-74').count.should eql(9)
    end
    
    it "should give you MTA Subway - Manhattan Bridge (B/D/N/Q) as the first trending venue" do
      foursquare.venues.trending(:ll => '40.7,-74').first.name.should eql('MTA Subway - Manhattan Bridge (B/D/N/Q)')
    end
    
  end
  
end