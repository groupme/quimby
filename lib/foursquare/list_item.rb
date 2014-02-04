module Foursquare
  class ListItem
    attr_reader :json
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def id	
      @json["id"]
    end
    
    def user	
      @json["user"]
    end
    
    def photo
      @json["photo"]	
    end
    
    def venue
      @json["venue"]	
    end
    
    def tip
      Foursquare::Tip.new(@foursquare, @json["tip"])
    end
    
    def note
      @json["note"]
    end	
    
    def created_at
      @json["createdAt"]
    end
    
    def todo?
      @json["todo"]	
    end
    
    def done
      @json["done"]
    end	 
    
    def visited_count
      @json["visitedCount"]
    end	
    
    def listed_count
      @json["listed"]["count"]
    end
    
    def listed_in_lists
      return [] if listed_count == 0
      @json["listed"]["items"].collect do | item |
        Foursquare::List.new(@foursquare, item)
      end
    end
    
    def user(full=false)
      return nil unless @json["user"]
      if full
        @foursquare.users.find(@json["user"]["id"])
      else
        Foursquare::User.new(@foursquare, @json["user"])
      end
    end
  
  end
end