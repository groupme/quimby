module Foursquare
  class Checkin
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def fetch
      @json = @foursquare.get("checkins/#{id}")["checkin"]
      self
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
