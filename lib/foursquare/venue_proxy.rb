module Foursquare
  class VenueProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Venue.new(@foursquare, @foursquare.get("venues/#{id}")["venue"])
    end
  end
end
