module Foursquare
  class ListItem
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def id
      @json["id"]
    end
    
    def user
      Foursquare::User.new(@foursquare, @json["user"])
    end
    
    def venue
      Foursquare::Venue.new(@foursquare, @json["venue"])
    end
    
    def todo?
      @json["todo"]
    end
    
    def done?
      @json["done"]
    end
    
    def visited
      @json["visited"]
    end
    
    def tip
      return nil if @json["tip"].blank?
      Foursquare::Tip.new(@foursquare, @json["tip"])
    end
    
  end
end