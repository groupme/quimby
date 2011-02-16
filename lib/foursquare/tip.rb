module Foursquare
  class Tip
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def text
      @json["text"]
    end

    def created_at
      @json["createdAt"]
    end

    def status
      @json["status"]
    end

    def photo
      @json["photo"]
    end

    def user
      @json["user"] && Foursquare::User.new(@foursquare, @json["user"])
    end

    def venue
      @json["venue"] && Foursquare::Venue.new(@foursquare, @json["venue"])
    end
  end
end
