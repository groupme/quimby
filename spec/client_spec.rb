require 'spec_helper'

describe Foursquare::Client do
  VCR.config do |c|
    c.default_cassette_options = {
      :record => :new_episodes}
  end

  let(:client) {Foursquare::Client.new}

  describe "#venue_categories" do
    use_vcr_cassette

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
      unique_keys.should == category_keys
    end

    it "gets the correct venue categories" do
      client.venue_categories.should eq(categories)
    end

    it "contains the correct number of categories" do
      client.venue_categories.count.should eq(categories.count)
    end
  end

  # # #create_special only works against the staging/sandbox api
  # describe "#create_special" do
  #   use_vcr_cassette

  #   it "publishes a special to the Foursquare api" do
  #     special = client.create_special(:special_params => "special")
  #     special.should == "special"
  #   end

  #   it "sets the type for the new special to the default value" do
  #     special = client.create_special
  #     special.type.should eq("offer")
  #   end

  #   it "sets the name of the new special to the passed in value" do
  #     special = client.create_special(:name => "new_special")
  #     special.name.should eq("new_special")
  #   end

  #   it "sets the text for the new special to the passed in value" do
  #     special = client.create_special(:text => "new_special_text")
  #     special.text.should eq("new_special_text")
  #   end

  #   it "sets the value for the new special to the passed in amount" do
  #     special = client.create_special(:value => "11.11")
  #     special.value.should == "11.11"
  #   end

  #   it "sets the cost for the new special to the passed in amount" do
  #     special = client.create_special(:cost => "1.11")
  #     special.cost.should == "1.11"
  #   end

  #   it "sets the purchase_url for the new special to the passed in string" do
  #     special = client.create_special(:purchase_url => "new_purchase_url")
  #     special.purchase_url.should == "new_purchase_url"
  #   end

  #   it "sets the exit_url for the new special to the passed in string" do
  #     special = client.create_special(:exit_url => "new_exit_url")
  #     special.exit_url.should == "new_exit_url"
  #   end
  # end

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
