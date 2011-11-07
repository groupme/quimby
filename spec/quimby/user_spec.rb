require 'spec_helper'


describe Foursquare::User do
  
  before(:each) do
    @json_item = JSON.parse(get_file("spec/fixtures/user_example.json"))
    @foursquare = Foursquare::Base.new("X1RBNDKTKO3DJY13PUQIGJDU2YQQ3KXL1KPO1UB2M5LAUPFB")
    @foursquare.stub(:get).with("users/703332/lists", {:group=>{}}).and_return(JSON.parse(get_file("spec/fixtures/user_lists_example.json")))
    @user = Foursquare::User.new(@foursquare, @json_item)
  end
  
  describe "Composed Attributes" do
    it "should fetch lists without group" do
      pending
      # @user.lists[0].name.should eql("My To-Do List")
      # @user.lists[1].id.should eql("4e7632de1838f9188a2dfe78")
      # @user.lists[2].description.should eql("Some places to eat good burgers in Paris")
    end
  end
end