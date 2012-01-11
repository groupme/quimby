require 'spec_helper'

describe Foursquare::User do
  
  before(:each) do
    @user = current_user
    
    # lists
    foursquare.stub(:get).with("users/17409817/lists", {:group => 'created'}).and_return(JSON.parse(get_file("spec/fixtures/users/lists/created.json")))
  end
  
  describe "Atomical Attributes" do 

    it "should get an id" do
      @user.id.should eql("17409817")
    end
    
    it "should get a name" do
      @user.name.should eql("Quimby API")
    end
    
    it "should get a first name" do
      @user.first_name.should eql("Quimby")
    end
    
    it "should get a last name" do
      @user.last_name.should eql("API")
    end
    
    it "shout get a photo" do
      @user.photo.should eql("https://foursquare.com/img/blank_girl.png")
    end
    
    it "shout get a gender" do
      @user.gender.should eql("female")
    end
    
    it "shout get a home_city" do
      @user.home_city.should eql("New York, NY")
    end
    
    it "shout get a relationship" do
      @user.relationship.should eql("self")
    end
    
    it "shout get an email" do
      @user.email.should eql("quimby@valade.info")
    end
    
  end
  
  describe "Composed Attributes" do
    it "should fetch created lists" do
      lists = @user.lists("created")
      list = lists.first
      list.id.should eql("4ed53e79722e6f1fdabeae6f")
      list.name.should eql("My First List")
    end
  end
  
end