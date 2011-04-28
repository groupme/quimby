module Foursquare
  class Photo
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def name
      @json["name"]
    end

    def created_at
      @json["createdAt"]
    end

    def url
      @json["url"]
    end

    def sizes
      @json["sizes"]
    end
    
    def square_300
      @square_300 ||= @json["sizes"]["items"].select { |i| i["width"] == 300 }.first
    end
    
    def square_300_url
      square_300["url"]
    end
    
    def square_100
      @square_100 ||= @json["sizes"]["items"].select { |i| i["width"] == 100 }.first
    end
    
    def square_100_url
      square_100["url"]
    end
    
    def square_36
      @square_36 ||= @json["sizes"]["items"].select { |i| i["width"] == 36 }.first
    end
    
    def square_36_url
      square_36["url"]
    end
    
  end
end
