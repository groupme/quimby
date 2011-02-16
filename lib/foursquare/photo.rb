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
  end
end
