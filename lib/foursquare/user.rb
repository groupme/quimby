module Foursquare
  class User
    attr_reader :json

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def fetch
      @json = @foursquare.get("users/#{id}")["user"]
      self
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
      fetch unless @json.has_key?("pings")
      @json["pings"]
    end

    def contact
      fetch unless @json.has_key?("contact")
      @json["contact"]
    end

    def email
      contact["email"]
    end

    def twitter
      contact["twitter"]
    end

    def phone_number
      contact["phone"]
    end

    def badge_count
      fetch unless @json.has_key?("badges")
      @json["badges"]["count"]
    end

    def mayorships
      fetch unless @json.has_key?("mayorships")
      @json["mayorships"]["items"]
    end
    
    # https://developer.foursquare.com/docs/users/checkins.html
    # https://developer.foursquare.com/docs/explore.html#req=users/self/checkins
    def checkins(options={})
      @foursquare.get("users/#{id}/checkins", options)["checkins"]["items"].map do |item|
        Foursquare::Checkin.new(@foursquare, item)
      end
    end
    
    def all_checkins
      count = 250
      offset = 0
      array = []
      while count == 250
        checkins = checkins(:limit => count, :offset => offset)
        array += checkins
        count = checkins.count
        offset = offset + count
      end
      array
    end

    def checkin_count
      fetch unless @json.has_key?("checkins")
      @json["checkins"]["count"]
    end

    def last_checkin
      fetch unless @json.has_key?("checkins")
      return unless @json["checkins"]["items"]
      item = @json["checkins"]["items"].last
      Foursquare::Checkin.new(@foursquare, item)
    end

    def checkins_here
      checkin_json = @foursquare.get("venues/#{last_checkin.venue.id}/herenow")
      checkin_json["hereNow"]["items"].map do |item|
        begin
          next unless json = @foursquare.get("checkins/#{item["id"]}")
          checkin = json["checkin"]
          Foursquare::Checkin.new(@foursquare, checkin)
        rescue Foursquare::Error
          # We can't get checkin information for people who aren't our friends.
        end
      end.compact
    end

    def friends(options={})
      @foursquare.get("users/#{id}/friends", options)["friends"]["items"].map do |item|
        Foursquare::User.new(@foursquare, item)
      end
    end

    def tips(options={})
      @foursquare.get("users/#{id}/tips", options)["tips"]["items"].map do |item|
        Foursquare::Tip.new(@foursquare, item)
      end
    end
  end
end
