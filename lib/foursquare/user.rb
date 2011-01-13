module Foursquare
  class User
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def name
      [first_name, last_name].join(' ').strip
    end

    def first_name
      @json["firstName"]
    end

    def last_name
      @json["lastName"]
    end

    def photo
      @json["photo"]
    end

    def gender
      @json["gender"]
    end

    def home_city
      @json["homeCity"]
    end

    def relationship
      @json["relationship"]
    end

    def pings
      @json["pings"]
    end

    def contact
      @json["contact"]
    end

    def badge_count
      @json["badges"]["count"]
    end

    def mayorships
      @json["mayorships"]["items"]
    end

    def checkin_count
      @json["checkins"]["count"]
    end

    def last_checkin
      item = @json["checkins"]["items"].last
      Foursquare::Checkin.new(@foursquare, item)
    end
  end
end
