require 'spec_helper'

describe Foursquare::ExploreItem do
  
  before(:each) do
    @json = JSON.parse(get_file("spec/fixtures/venues/explore/venues.json"))
    @result = Foursquare::ExploreResult.new(foursquare, @json)
    @item = @result.groups['recommended']['items'].first
  end

  describe "Explore result" do
    
    it "should have reasons" do
      @item.reasons.should_not be_blank
    end
    
    it "should have a good reason" do
      @item.reasons.first['message'].should eql('A lot of people talk about this place')
    end
    
    it "should have a venue" do
      @item.venue.should_not be_blank
    end
    
    it "should have a correct venue" do
      @item.venue.name.should eql("Grimaldi's Pizzeria")
    end
    
    it "should have tips" do
      @item.tips.should_not be_blank
    end
    
    it "should have a correct tip" do
      @item.tips.first.id.should eql("4c62b64eedb29c74df3a2ca7")
    end
    
  end
  
end