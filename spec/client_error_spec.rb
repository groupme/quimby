require 'spec_helper'    

VCR.eject_cassette
VCR.turn_off!

def rrand(x)
  rand(2*x) - x
end

describe Foursquare::Client do
  let(:client) {Foursquare::Client.new}

  # Special data looks like:
  # Required Fields
  #   text:        special text (shown when the user has unlocked the special). 500 char limit.
  #   type:        special type = "offer"
  #   exitUrl:     
  #   value:       value of goods offered (as a string, e.g., “5.00”)
  #   cost:        cost to purchase the discount (as a string, e.g., “5.00”)
  #   images:      comma-separated list of image URLs (URL-encoded)
  #   purchaseUrl: URL where the “buy now” button will link to (URL-encoded)
  describe "error states for creating specials" do
    new_special_params = {name: "New Test Special",
                          text: "New special text",
                          type: "offer",
                          value: "11.11",
                          exitUrl: "http://foo.com",
                          cost: "1.11",
                          images: "img1, img2",
                          purchaseUrl: "purchase_link"}

    it "throws an error if required data is missing" do
      expect {client.create_special_from({})}.to raise_error
    end

    new_special_params.each do |key, value| 
      err_msg = "Must provide parameter #{key}"
      params_copy = new_special_params.dup
      params_copy.delete(key)

      it "returns the correct message if #{key} is missing" do
        expect {client.create_special_from(params_copy)}.
          to raise_error(StandardError, err_msg)
      end
    end

    it "throws an error if the oauth token is expired" 
    # response body for expired token is:
    # #<Typhoeus::Response:0x000001028ba8c8 @app_connect_time=2.7e-05, @body=  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<unauthorized>TOKEN_EXPIRED</unauthorized>  \n  ", @code=401,
    #
  end

  # Venue data looks like:
  # Required fields
  #   name:        the name of the venue
  #   ll:          latitude and longitude of the venue, as accurate as is known.
  describe "error states for creating venues" do
    new_venue_params = {
      :name => "Test Venue #{Time.now.nsec}", :ll => "44.3,37.2"}

    it "raises an error if required data is missing" do
      expect {client.create_venue_from({})}.to raise_error
    end

    it "raises an error on creation of a possible duplicate venue" do
      venue = client.create_venue_from(new_venue_params)
      err_msg = "Possible duplicate venue, e.g. #{venue['id']}"
      expect {client.create_venue_from(new_venue_params)}.
        to raise_error(StandardError, err_msg)
    end

    new_venue_params.each do |key, value| 
      lat, long = rrand(90), rrand(180)
      new_venue_params[:ll] = "#{lat}, #{long}"

      params_copy = new_venue_params.dup
      params_copy.delete(key)

      err_msg = "Must provide parameter #{key}"
      it "raises an error with: #{err_msg} if #{key} is missing" do
        expect {client.create_venue_from(params_copy)}.
          to raise_error(StandardError, err_msg)
      end
    end

    it "throws an error if the oauth token is expired" 
  end
end
