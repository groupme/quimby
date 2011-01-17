module Foursquare
  class CheckinProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Checkin.new(@foursquare, @foursquare.get("checkins/#{id}")["checkin"])
    end

    def recent
      @foursquare.get("checkins/recent")["recent"].map do |json|
        Foursquare::Checkin.new(@foursquare, json)
      end
    end
  end
end
