module Foursquare
  class CheckinProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Checkin.new(@foursquare, @foursquare.get("checkins/#{id}")["checkin"])
    end

    def recent(options={})
      @foursquare.get("checkins/recent", options)["recent"].map do |json|
        Foursquare::Checkin.new(@foursquare, json)
      end
    end

    def all(options={})
      @foursquare.get("users/self/checkins", options)["checkins"]["items"].map do |json|
        Foursquare::Checkin.new(@foursquare, json)
      end
    end
  end
end
