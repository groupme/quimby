module Foursquare
  class List
    attr_reader :json

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def id
      @json["id"]
    end

    def fetch
      @json = @foursquare.get("lists/#{id}")["list"]
      self
    end
    
    def name
      @json["name"]
    end
     
    def description
      @json["description"]
    end
    
    def editable
      @json["editable"]
    end
    
    def public
      @json["public"]
    end
    def collaborative
      @json["collaborative"]
    end
    def url
      @json["url"]
    end
    def canonical_url
      @json["canonicalUrl"]
    end
    def done_count
      @json["doneCount"]
    end
    
    def visited_count
      @json["visitedCount"]
    end
    
    def venue_count
      @json["venueCount"]
    end
    
    def following
      @json["following"]
    end

    def photo
      @json["photo"]
    end
    
    def followers_count
      @json["followers"]["count"]
    end
    
    def followers
      return [] if followers_count == 0
      @json["followers"]["items"].collect do | item |
        Foursquare::User.new(@foursquare, item)
      end
    end
    
    def collaborators_count
      @json["collaborators"]["count"]
    end
    
    def collaborators
      return [] if followers_count == 0
      @json["collaborators"]["items"].collect do | item |
        Foursquare::User.new(@foursquare, item)
      end
    end
    
    
    
    def list_items(options={})
      @json["listItems"]["items"].collect do | item |
        Foursquare::Checkin.new(@foursquare, item)
      end
    end
    
    def list_items_count
      @json["listItems"]["count"]
    end
    
    def user(full=false)
      fetch unless @json["user"]
      if full
        @foursquare.users.find(@json["user"]["id"])
      else
        Foursquare::User.new(@foursquare, @json["user"])
      end
    end
    
  end
end