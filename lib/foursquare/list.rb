module Foursquare
  class List
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def fetch
      @json = @foursquare.get("lists/#{id}")["list"]
      self
    end
    
    def json
      @json
    end
    
    def id
      @json["id"]
    end
    
    def name
      @json["name"]
    end
    
    def description
      @json["description"]
    end
    
    def following?
      @json["following"]
    end
    
    def followers
      fetch if @json["followers"]["items"].blank?
      
      @json["followers"]["items"].map do |user|
        Foursquare::User.new(@foursquare, user)
      end
    end
    
    def collaborators
      fetch if @json["collaborators"]["items"].blank?
      
      @json["collaborators"]["items"].map do |user|
        Foursquare::User.new(@foursquare, user)
      end
    end
    
    def user
      Foursquare::User.new(@foursquare, @json["user"])
    end
    
    def editable?
      @json["editable"]
    end
    
    def public?
      @json["public"]
    end
    
    def collaborative?
      @json["collaborative"]
    end
    
    def url
      @json["url"]
    end
    
    def canonical_url
      @json["canonicalUrl"]
    end
    
    def created_at
      @json["createdAt"]
    end
    
    def updated_at
      @json["updatedAt"]
    end
    
    def photo
      Foursquare::Photo.new(@foursquare, @json["photo"])
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
    
    def list_items
      fetch if @json["listItems"]["items"].blank?
      
      @json["listItems"]["items"].map do |item|
        Foursquare::ListItem.new(@foursquare, item)
      end
    end
    
  end
end