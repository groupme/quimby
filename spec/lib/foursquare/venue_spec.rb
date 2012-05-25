require 'spec_helper'

describe Foursquare::Venue do
  
  before(:each) do
    foursquare.stub(:get).with("venues/4ab7e57cf964a5205f7b20e3").and_return(JSON.parse(get_file("spec/fixtures/venues/foursquarehq.json")))
    @foursquarehq = foursquare.venues.find('4ab7e57cf964a5205f7b20e3')
    
    # without categories
    foursquare.stub(:get).with("venues/4d8642e540a7a35d028831be").and_return(JSON.parse(get_file("spec/fixtures/venues/khloe.json")))
    @khloe = foursquare.venues.find('4d8642e540a7a35d028831be')
  end
  
  describe "Atomical Attributes" do 

    it "should get an id" do
      @foursquarehq.id.should eql("4ab7e57cf964a5205f7b20e3")
      @khloe.id.should eql("4d8642e540a7a35d028831be")
    end
    
    it "should get a name" do
      @foursquarehq.name.should eql("foursquare HQ")
    end
    
    it "should get a twitter handle" do
      @foursquarehq.twitter.should eql('foursquare')
    end
    
    it "should get a location" do
      @foursquarehq.location.should_not be_false
    end
    
    it "should get a category" do
      @foursquarehq.categories.first.name == "Tech Startup"
    end
    
    it "should be verified" do
      @foursquarehq.verified?.should be_true
    end
    
    it "should have an icon" do
      @foursquarehq.icon.url.should eql("https://foursquare.com/img/categories/building/default_32.png")
    end
    
    it "should have a default icon" do
      @khloe.icon.url.should eql("https://foursquare.com/img/categories/none_32.png")
    end
    
    it "should have 273 photos" do
      @foursquarehq.photos_count.should eql(273)
    end
    
    it "shoud have all the photos" do
      pending
    end
    
    it "should have tips" do
      pending
    end
    
    it "should have here_now count" do
      pending
    end
    
    it "should have here_now checkins" do
      pending
    end
    
  end
  
  describe "Composed Attributes" do
    it "should fetch photos" do
    end
  end
  
end