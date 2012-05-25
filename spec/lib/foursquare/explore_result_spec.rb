require 'spec_helper'

describe Foursquare::ExploreResult do
  
  before(:each) do
    @json = JSON.parse(get_file("spec/fixtures/venues/explore/venues.json"))
    @result = Foursquare::ExploreResult.new(foursquare, @json)
  end

  describe "Explore result" do
    
    it "should have keywords" do
      @result.keywords.should_not be_blank
    end
    
    it "should have 30 keywords" do
      @result.keywords.count.should eql(30)
    end
    
    it "should have groups" do
      @result.groups.should_not be_blank
    end
    
    it "should have a recommended group" do
      @result.groups['recommended'].should_not be_blank
    end
    
    it "should have only a recommended group" do
      @result.groups.keys.should eql(["recommended"])
    end
    
    it "should have a recommended group that has items" do
      @result.groups['recommended']['items'].should_not be_blank
    end
    
  end
  
end