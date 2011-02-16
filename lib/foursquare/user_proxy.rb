module Foursquare
  class UserProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def self.search(foursquare, options={})
      
    end

    def find(id)
      Foursquare::User.new(@foursquare, @foursquare.get("users/#{id}")["user"])
    end

    def search(options={})
      @foursquare.get("users/search", options)["results"].map do |json|
        Foursquare::User.new(@foursquare, json)
      end
    end
  end
end
