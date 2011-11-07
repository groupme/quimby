# some mixins over here (to be able to use Object#blank?() for example)
require "spec_helper"

describe Foursquare::ListItem do

  before(:each) do
    @json_item = JSON.parse(File.open("spec/fixtures/item_example.json", "rb") do | file |
      file.read
    end)
    @foursquare = Foursquare::Base.new("ACCESS_TOKEN")
    @item = Foursquare::ListItem.new(@foursquare, @json_item)
  end
  

  
  describe "Atomic Attributes" do
    
    it "should not be done" do
      
    end
    
    it "should have a venue" do
      @item.venue.should_not be_nil
      @item.venue.id.should eql("4ba2aa53f964a5200e0e38e3")
    end
    
    it "should have a tip" do
      @item.tip.text.should eql("Go there for dinner with some friends and ask for the central table in front of the Dj.")
    end
    
    it "should not have a note" do
      pending
      #@item.note.should be_nil
    end
    
    
    it "should have been created at 1271717431" do
      pending
      #@item.created_at.should eql(1271717431)
    end
    
    it "should not wanted to be done" do
      @item.todo?.should be_false
    end
    
    it "should be done" do
      @item.done?.should be_true
    end
    
    it "should have visited by 0 people" do
      pending
      #@item.visited_count.should eql(0)
    end
    
    it "should not have a photo" do
      pending
      #@item.photo.should be_nil
    end
    
  end
  

  describe "Composed Attributes" do
    
    it "should not be listed" do
      pending
    end
    
    it "should have an user" do
      @item.user.should_not be_nil
    end
    
  end
  
end