require "spec_helper"

describe Foursquare::ListItem do

  before(:each) do
    @json = JSON.parse(get_file("spec/fixtures/lists/list/item.json"))
    @item = Foursquare::ListItem.new(foursquare, @json)
  end
  
  describe "Atomic Attributes" do
    
    it "should have a venue" do
      @item.venue.should_not be_nil
      @item.venue.id.should eql("43695300f964a5208c291fe3")
    end
    
    it "should have a tip?" do
      @item.tip?.should be_true
    end
    
    it "should have a tip text" do
      @item.tip.text.should eql("my first tip")
    end
    
    it "should have a photo?" do
      @item.photo?.should be_true
    end
    
    it "should have a photo id" do
      @item.photo.id.should eql('4ed3af6ab8f7971d6e75396e')
    end
    
    it "should have been created at 1322601499" do
      @item.created_at.to_i.should eql(1322601499)
    end
    
    it "should not wanted to be done" do
      @item.todo?.should be_false
    end
    
    it "should be done" do
      @item.done?.should be_true
    end
    
    it "should have visited by 0 people" do
      @item.visited_count.should eql(0)
    end
    
  end
  
  describe "Composed Attributes" do
    
    it "should have an user" do
      @item.user.should_not be_nil
    end
    
  end
  
end