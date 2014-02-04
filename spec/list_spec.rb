require 'spec_helper'

describe Foursquare::List do
  
  before(:each) do
    @json_item = JSON.parse(File.open("spec/fixtures/list_item_example.json", "rb") do | file |
      file.read
    end)
    @foursquare = Foursquare::Base.new("ACCESS_TOKEN")
    @list = Foursquare::List.new(@foursquare, @json_item)
  end
  
  it "should initialize a list" do
    test_list = Foursquare::List.new(@foursquare, @json_item)
    test_list.json.should eql(@json_item) 
  end
  
  
  describe "Atomical Attributes" do 

    
    it "should get an id" do
      @list.id.should eql("703332/tips") 
    end

    it "should get a name" do
      @list.name.should eql("My Tips") 
    end
    
    it "should get a description" do
      @list.description.should eql("") 
    end

    it "should not be editable" do
      @list.editable.should eql(false) 
    end
    
    it "should not be collaborative" do
      @list.collaborative.should eql(false) 
    end

    it "should get canonicalUrl" do
      @list.canonical_url.should eql("https://foursquare.com/user/703332/list/tips") 
    end
    
    it "should get done count" do
      @list.done_count.should eql(2) 
    end
    
    it "should get visited count" do
      @list.visited_count.should eql(1) 
    end
    
    it "should not be venue count" do
      @list.venue_count.should eql(2) 
    end
    
    it "should not be following" do
      @list.following.should eql(false)
      
    end
    
    it "should not get photo" do
     @list.photo.should be_nil
      
    end
    
  end

  describe "Composed Attributes" do
    
    it "should have a user" do
      @list.user.first_name.should eql("Vincent")
      @list.user.last_name.should eql("Coste")
    end
    
    it "should have 0 followers" do
      @list.followers_count.should eql(0)
      @list.followers.should eql([])
    end
    
    it "should have 0 collaborators" do
      @list.collaborators_count.should eql(0)
      @list.collaborators.should eql([])
    end
    
    it "should have 2 items" do
      @list.list_items_count.should eql(2)
      @list.list_items[0].id.should eql("t4bccde3770c603bb947898b4")
      @list.list_items[1].id.should eql("t4bccdd6970c603bb7f7898b4")
    end
    
  end
  
end