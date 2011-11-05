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
    
    def photos
      return [] if @json["photos"]["items"].blank?
      
      @json["photos"]["items"].map do |photo|
        Foursquare::Photo.new(@foursquare, photo)
      end
    end
    
    def comments?
      # some checkins don't have a comments attribute (following model)
      (@json["comments"] && @json["comments"]["count"] != 0) ? true : false
    end
    
    def comments
      return [] unless comments?
      fetch if @json["comments"]["items"].blank?
      
      @json["comments"]["items"].map do |comment|
        Foursquare::Comment.new(@foursquare, comment)
      end
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
