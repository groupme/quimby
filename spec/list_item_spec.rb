require "spec_helper"

describe Foursquare::ListItem do

  before(:each) do
    @json_item = JSON.parse(File.open("spec/fixtures/item_example.json", "rb") do | file |
      file.read
    end)
    @foursquare = Foursquare::Base.new("ACCESS_TOKEN")
    @item = Foursquare::ListItem.new(@foursquare, @json_item)
  end
  
  it "should initialize an item" do
    test_item = Foursquare::ListItem.new(@foursquare, @json_item)
    test_item.json.should eql(@json_item) 
  end
  
  describe "Atomic Attributes" do
    
    it "should have a tip" do
      @item.tip.text.should eql("Go there for dinner with some friends and ask for the central table in front of the Dj.")
    end
    
    it "should not have a note" do
      @item.note.should be_nil
    end
    
    it "should have been created at 1271717431" do
      @item.created_at.should eql(1271717431)
    end
    
    it "should wanted to be done" do
      @item.todo?.should eql(false)
    end
    
    it "should have visited by 0" do
      @item.visited_count.should eql(0)
    end
    
    it "should not have a photo" do
      @item.photo.should be_nil
    end
    
  end
  

  describe "Composed Attributes" do
    
    it "should not be listed" do
      @item.listed_count.should eql(0)
      @item.listed_in_lists.should eql([])
    end
    
    it "should have not have an user" do
      @item.user.should be_nil
    end
    
  end
  
end