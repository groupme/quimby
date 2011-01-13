module Foursquare
  class CheckinProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Checkin.new(@foursquare, @foursquare.get("checkins/#{id}")["checkin"])
    end
  end
end
