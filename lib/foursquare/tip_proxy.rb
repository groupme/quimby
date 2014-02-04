module Foursquare
  class TipProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Venue.new(@foursquare, @foursquare.get("tips/#{id}")["tip"])
    end

    def search(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]
      @foursquare.get("tips/search", options)["tips"].map do |json|
        Foursquare::Tip.new(@foursquare, json)
      end
    end
  end
end