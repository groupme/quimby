module Foursquare
  class Checkin
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def shout
      @json["shout"]
    end

    def mayor?
      @json["isMayor"]
    end

    def timezone
      @json["timeZone"]
    end

    def venue
      Foursquare::Venue.new(@foursquare, @json["venue"])
    end
  end
end
