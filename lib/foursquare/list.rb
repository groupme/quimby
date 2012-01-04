module Foursquare
  class List
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
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
    
    def followers
      @json["followers"]
    end
    
    def url
      @json["canonicalUrl"]
    end
    
    def photo
      @json["photo"]
    end
    
    def venue_count
      @json["venueCount"]
    end

    def item_count
      @json["listItems"]["count"]
    end
    
    def items
      @items ||= @json["listItems"]["items"].map { |hash| Foursquare::Item.new(hash) }
    end
  
  end
end