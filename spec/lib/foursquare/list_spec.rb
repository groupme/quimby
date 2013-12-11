require 'spec_helper'

describe Foursquare::List do
  
  before(:each) do
    foursquare.stub(:get).with("lists/4ed53e79722e6f1fdabeae6f").and_return(JSON.parse(get_file("spec/fixtures/lists/4ed53e79722e6f1fdabeae6f.json")))
    @list = foursquare.lists.find("4ed53e79722e6f1fdabeae6f")
  end
  
  describe "Atomical Attributes" do 

    it "should get an id" do
      @list.id.should eql("4ed53e79722e6f1fdabeae6f") 
    end

    it "should get a name" do
      @list.name.should eql("My First List") 
    end
    
    it "should get a description" do
      @list.description.should eql("my description") 
    end

    it "should not be editable" do
      @list.editable?.should eql(true) 
    end
    
    it "should not be collaborative" do
      @list.collaborative?.should eql(false) 
    end

    it "should get canonicalUrl" do
      @list.canonical_url.should eql("https://foursquare.com/user/17409817/list/my-first-list") 
    end
    
    it "should get done count" do
      @list.done_count.should eql(0) 
    end
    
    it "should get visited count" do
      @list.visited_count.should eql(0) 
    end
    
    it "should have 2 venues" do
      @list.venue_count.should eql(2) 
    end

    
    it "should not get photo" do
     @list.photo.should_not be_nil
    end
    
    it "should have no followers" do
      @list.followers?.should be_false
    end
    
  end

  describe "Composed Attributes" do
    
    it "should have a user" do
      @list.user.first_name.should eql("Quimby")
      @list.user.last_name.should eql("API")
    end
    
    it "should have 0 followers" do
      @list.should have(0).followers
    end
    
    it "should have 0 collaborators" do
      @list.should have(0).collaborators
    end
    
    it "should have 2 items" do
      @list.should have(2).list_items
      @list.list_items[0].id.should eql("v43695300f964a5208c291fe3")
      @list.list_items[1].id.should eql("v4a2fc4d3f964a520da981fe3")
    end
    
  end
  
end