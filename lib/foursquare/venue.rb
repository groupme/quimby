module Foursquare
  class Venue
    attr_reader :json

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def name
      @json["name"]
    end

    def contact
      @json["contact"]
    end

    def location
      @json["location"]
    end

    def categories
      @json["categories"]
    end

    def verified?
      @json["verified"]
    end

    def checkins_count
      @json["stats"]["checkinsCount"]
    end

    def users_count
      @json["stats"]["usersCount"]
    end

    def todos_count
      @json["todos"]["count"]
    end

    def photos(options={:group => "checkin"})
      @foursquare.get("venues/#{id}/photos", options)["photos"]["items"].map do |item|
        Foursquare::Photo.new(@foursquare, item)
      end
    end
  end
end
