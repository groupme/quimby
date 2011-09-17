module Foursquare
  class Comment
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def created_at
      @json["createdAt"]
    end
    
    def text
      @json["text"]
    end

    def user
      @json["user"] && Foursquare::User.new(@foursquare, @json["user"])
    end
    
  end
end
