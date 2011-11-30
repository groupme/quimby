module Foursquare
  class ListItem
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def id
      @json["id"]
    end
    
    def created_at
      Time.at(@json["createdAt"].to_i)
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
    
    def visited_count
      @json["visitedCount"]
    end
    
    def tip?
      !@json["tip"].blank?
    end
    
    def tip
      return nil unless tip?
      Foursquare::Tip.new(@foursquare, @json["tip"])
    end
    
    def photo?
      !@json["photo"].blank?
    end
    
    def photo
      return nil unless photo?
      Foursquare::Photo.new(@foursquare, @json["photo"])
    end
    
  end
end