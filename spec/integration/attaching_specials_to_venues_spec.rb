require 'spec_helper'

VCR.eject_cassette
VCR.turn_off!

# method for associating specials with venues
describe "#create_campaign_from" do
  let(:client) {Foursquare::Client.new}

  let(:new_special_params) do
    {name: "New Test Special",
     text: "New Special Text",
     type: "offer",
     value: "11.11",
     exitUrl: "http://foo.com",
     cost: "1.11",
     images: "img1,img2",
     purchaseUrl: "http://somespecial.com",
     offerId: "012345"}
  end

  let(:new_venue_params) do
    {:name => "Test Venue #{rand(Time.now.nsec)}",
     :address => "#{Time.now.nsec.to_s[0..4]} Mockingbird Lane",
     :cross_street => "at Fulton St",
     :city => "New York",
     :state => "New York",
     :zip => "54321",
     :phone => "5555551234",
     :ll => "#{rrand(90)}, #{rrand(180)}"}
  end

  it "attaches the passed in special to one passed in venue" do
    special = client.create_special_from(new_special_params)
    venue = client.create_venue_from(new_venue_params)
    venues = [venue]
    campaign_params = {:special => special, :venues => venues}
    campaign = client.create_campaign_from(campaign_params)
    campaign.should be_a(Hash)
  end

  it "contains the expected keys" do
    expected_keys = ["id", "venues", "special", "venueGroups"]
    special = client.create_special_from(new_special_params)
    venue = client.create_venue_from(new_venue_params)
    venues = [venue]
    campaign_params = {:special => special, :venues => venues}
    campaign = client.create_campaign_from(campaign_params)
    campaign.values.first.keys.should include(*expected_keys)
  end

  it "contains the expected values" do
    special = client.create_special_from(new_special_params)
    venue = client.create_venue_from(new_venue_params)
    venues = [venue]
    campaign_params = {:special => special, :venues => venues}
    campaign = client.create_campaign_from(campaign_params)

    campaign_venue_groups = {"count" => 0, "items" => []}

    campaign_special = {
      "id" => special["id"],
      "name" => special["name"],
      "text" => special["text"]}

    campaign_venues = {
      "count" => 1, "items" => [{"id" => venue["id"]}]}

    campaign_attrs = campaign["campaign"]

    campaign_attrs["id"].should be_true

    campaign_attrs["venues"]["count"].should == 1
    campaign_attrs["venues"].should == campaign_venues
    campaign_attrs["special"].should == campaign_special
    campaign_attrs["venueGroups"].should == campaign_venue_groups
  end
end
