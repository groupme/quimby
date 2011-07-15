require 'spec_helper'

class Hash
  def method_missing(sym, *args, &block)
    if self[sym.to_s] 
      self[sym.to_s] 
    else
      super
    end
  end
end

# VCR.eject_cassette
# VCR.turn_off!

describe Foursquare::Client do
  VCR.config do |c|
    c.default_cassette_options = {:record => :new_episodes}
  end
  use_vcr_cassette

  let(:client) {Foursquare::Client.new}

  describe "#venue_categories" do
    # use_vcr_cassette

    let(:endpoint) do
      client.configuration.endpoint + "venues/categories"
    end
    let(:request_params) do
      {:params => {:oauth_token => client.configuration.oauth_token}}
    end
    let(:response) do
      Typhoeus::Request.get(endpoint, request_params)
    end
    let(:categories) {JSON.parse(response.body)["response"]["categories"]}

    it "returns an array" do
      client.venue_categories.should be_a(Array)
    end

    it "contains category hashes" do
      client.venue_categories.first.should be_a(Hash)
    end

    it "contains well formed objects" do
      category_keys = ["name", "pluralName", "icon", "categories"]
      unique_keys = client.venue_categories.map {|c| c.keys}.uniq.flatten
      unique_keys.should =~ category_keys
    end

    it "gets the correct venue categories" do
      client.venue_categories.should eq(categories)
    end

    it "contains the correct number of categories" do
      client.venue_categories.count.should eq(categories.count)
    end
  end

  describe "#create_venue_from" do
    # use_vcr_cassette

    # Venue data looks like 
    # name  Habana Outpost  required the name of the venue
    # address 1313 Mockingbird Lane The address of the venue.
    # crossStreet at Fulton St  The nearest intersecting street or streets.
    # city  New York  The city name where this venue is.
    # state new York  The nearest state or province to the venue.
    # zip AE1234  The zip or postal code for the venue.
    # phone 00 01 23 1234 The phone number of the venue.
    # ll  44.3,37.2 required Latitude and longitude of the venue, as accurate as is known.
    # primaryCategoryId 4bf58dd8d48988d1d4941735
    new_venue_params = {:name => "Test Venue #{Time.now.nsec}",
                        :address => "1313 Mockingbird Lane",
                        :cross_street => "at Fulton St",
                        :city => "New York",
                        :state => "New York",
                        :zip => "54321",
                        :phone => "5555551234",
                        :ll => "#{rrand(90)}, #{rrand(180)}"}

    let(:venue_params) do
      {:name => "Test Venue #{Time.now.nsec}",
       :address => "1313 Mockingbird Lane",
       :cross_street => "at Fulton St",
       :city => "New York",
       :state => "New York",
       :zip => "54321",
       :phone => "5555551234",
       :ll => "#{rrand(90)}, #{rrand(180)}"}
    end

    let(:venue) {client.create_venue_from(venue_params)}

    it "publishes a venue to the Foursquare api" do
      venue.should be_true
    end

    it "returns a hash containing the new foursquare venue" do
      venue.should be_a(Hash)
    end

    it "has the expected keys" do
      expected_keys = [
        "id", "name", "verified", "contact", "location", 
        "categories", "specials", "hereNow"]
      venue.keys.should include(*expected_keys)
    end

    it "returns the id for the new venue" do
      venue["id"].should be
    end

    it "sets the name for the new venue to the passed in value" do
      name = "Test Venue #{rand(Time.now.nsec)}"
      new_params = venue_params.merge(:name => name)
      venue = client.create_venue_from(new_params)
      venue["name"].should =~ /test venue/i
    end

    it "sets the contact phone attr to the passed in value" do
      venue["contact"]["phone"].should eq(venue_params[:phone])
    end

    describe "location attributes" do
      address_attrs = {:address => "1313 Mockingbird Lane",
                       :crossStreet => "at Fulton St",
                       :city => "New York",
                       :state => "New York",
                       :postalCode => "54321"}

      address_attrs.each do |key, value|
        it "sets #{key} to #{value}" do
          venue["location"][key.to_s].should eq(value)
        end
      end
    end
 end

  # method for associating specials with venues
  # describe "#attach_special_to"

  # Presently, #create_special only works against the staging/sandbox api
  # The user must own venues before being able to create specials
  describe "#create_special_from" do
    # use_vcr_cassette

    # Special data looks like:
    # Required Fields
    #   text:        special text (shown when the user has unlocked the special). 500 char limit.
    #   type:        special type = "offer"
    #   exitUrl:     
    #   value:       value of goods offered (as a string, e.g., “5.00”)
    #   cost:        cost to purchase the discount (as a string, e.g., “5.00”)
    #   images:      comma-separated list of image URLs (URL-encoded)
    #   purchaseUrl: URL where the “buy now” button will link to (URL-encoded)
    #
    # Optional fields
    #   name:        name for the special (optional)
    #   offerId:     partner’s internal ID for the offer (any string)
    #   layout:      determines whether the image is placed to the right (portrait)
    #                or above ("landscape") the title. Defaults to landscape.
    #   currency:    currency denomination (optional, default is “USD”)
    #   finePrint:   fine print (optional, shown in small type on the special detail page). 200 char limit.
    #   desktopUrl:  optional, alternate URL to send desktop based users if purchaseUrl is mobile-only

    new_special_params = {name: "New Test Special",
                          text: "New special text",
                          type: "offer",
                          value: "11.11",
                          exitUrl: "http://foo.com",
                          cost: "1.11",
                          images: "img1,img2",
                          purchaseUrl: "http://somespecial.com",
                          offerId: "012345"}

    let(:special) {client.create_special_from(new_special_params)}

    it "publishes a special to the Foursquare api" do
      special.should be_true
    end

    it "returns a hash containing the new foursquare special" do
      special.should be_a(Hash)
    end

    it "has the expected keys" do
      expected_keys = ["id",
                       "type",
                       "status",
                       "name",
                       "text",
                       "offerId",
                       "purchaseUrl",
                       "exitUrl",
                       "cost",
                       "value",
                       "imageUrls"]
      special.keys.should include(*expected_keys)
    end

    it "returns the id for the new venue" do
      special["id"].should be
    end

    it "returns the cost as an integer representation of cents" do
      special["cost"].should eq(111)
    end

    it "returns the value as an integer representation of cents" do
      special["value"].should eq(1111)
    end

    it "returns an array of image urls" do
      special["imageUrls"].should =~ ["img1", "img2"]
    end

    non_mutated_params = new_special_params.reject do |p| 
      [:cost, :value, :images].include?(p)
    end

    non_mutated_params.each do |key, value|
      it "sets #{key} to #{value}" do
        special.send("#{key}").should eq(value)
      end
    end
  end

  describe "#valid_date_string" do
    it "returns a string with the current YYYYMMDD" do
      valid_date_string = Time.new.strftime("%Y%m%d")
      Foursquare::Client.new.send(:valid_date_string).should == valid_date_string
    end
  end
end

# it "searches for venues by name" do
#   VCR.use_cassette('denver_zoo', :record => :new_episodes) do
#     endpoint = APPCONFIG[:api][:url]
#     http_username = APPCONFIG[:auth][:basic][:username]
#     http_password = APPCONFIG[:auth][:basic][:password]
#     oauth_token = APPCONFIG[:auth][:oauth][:access_token]
#     client_params = {
#       :endpoint => endpoint,
#       :http_username => http_username,
#       :http_password => http_password,
#       :oauth_token => oauth_token}
#       client = Foursquare::Client.new(client_params)
#       @denver_zoo = client.venues.search("118057")
#       @denver_zoo.url.should == 'http://www.denverzoo.org'
#   end
# end

# it "finds a venue by integer id" do
#   VCR.use_cassette('denver_zoo', :record => :new_episodes) do
#     endpoint = APPCONFIG[:api][:url]
#     http_username = APPCONFIG[:auth][:basic][:username]
#     http_password = APPCONFIG[:auth][:basic][:password]
#     oauth_token = APPCONFIG[:auth][:oauth][:access_token]
#     client_params = {
#       :endpoint => endpoint,
#       :http_username => http_username,
#       :http_password => http_password,
#       :oauth_token => oauth_token}
#     client = Foursquare::Client.new(client_params)
#     # TODO: Implement the following proposed interface
#     # @denver_zoo = client.venues["118057"]
#     @denver_zoo = client.venues.find("118057")
#     @denver_zoo.url.should == 'http://www.denverzoo.org'
#   end
# end
# let(:client_params) do
#   {:access_token => APPCONFIG[:auth][:oauth][:access_token],
#    :api => APPCONFIG[:api][:url],
#    :client_id => APPCONFIG[:auth][:shared_secret][:client_id],
#    :client_secret => APPCONFIG[:auth][:shared_secret][:client_id]}
# end

# it "connects using the endpoint configuration" do
#   client = Foursquare::Client.new
#   endpoint = URI.parse(client.api_endpoint).to_s.gsub(/\/$/, '')
#   connection = client.send(:connection).build_url(nil).to_s
#   connection.should == endpoint
# end

# it "correctly initializes the oauth access token in config" do
#   access_token = APPCONFIG[:auth][:oauth][:access_token]
#   oauth = foursquare.config[:auth][:oauth]
#   oauth[:access_token].should == access_token
# end

# it "correctly initializes the client_id in the config params" do
#   client_id = APPCONFIG[:auth][:shared_secret][:client_id]
#   shared_secret = foursquare.config[:auth][:shared_secret]
#   shared_secret[:client_id].should == client_id
# end

# it "correctly initializes the client_secret in the config params" do
#   client_id = APPCONFIG[:auth][:shared_secret][:client_secret]
#   shared_secret = foursquare.config[:auth][:shared_secret]
#   shared_secret[:client_secret].should == client_secret
# end

# it "correctly initializes the username in the config params" do
#   username = APPCONFIG[:auth][:basic][:username]
#   basic_auth = foursquare.config[:auth][:basic]
#   basic_auth[:username].should == username
# end

# it "correctly initializes the username in the config params" do
#   password = APPCONFIG[:auth][:basic][:password]
#   basic_auth = foursquare.config[:auth][:basic]
#   basic_auth[:password].should == password
# end
