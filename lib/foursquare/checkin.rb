module Foursquare
  class Checkin
    attr_reader :json

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

    def type
      @json["type"]
    end

    def shout?
      type == "shout"
    end

    def created_at
      Time.at(@json["createdAt"].to_i)
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
      @json["venue"] && Foursquare::Venue.new(@foursquare, @json["venue"])
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
