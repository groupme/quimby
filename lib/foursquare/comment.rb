module Foursquare
  class Comment
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def created_at
      Time.at(@json["createdAt"].to_i)
    end
    
    def text
      @json["text"]
    end

    def user
      @json["user"] && Foursquare::User.new(@foursquare, @json["user"])
    end
    
  end
end
