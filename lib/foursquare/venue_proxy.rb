module Foursquare
  class VenueProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Venue.new(@foursquare, @foursquare.get("venues/#{id}")["venue"])
    end

    def search(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]
      response = @foursquare.get('venues/search', options)["groups"].inject({}) do |venues, group|
        venues[group["type"]] ||= []
        venues[group["type"]] += group["items"].map do |json|
          Foursquare::Venue.new(@foursquare, json)
        end
        venues
      end
    end

    def trending(options={})
      search_group("trending", options)
    end

    def favorites(options={})
      search_group("favorites", options)
    end

    def nearby(options={})
      search_group("nearby", options)
    end

    private

    def search_group(name, options)
      raise ArgumentError, "You must include :ll" unless options[:ll]
      response = @foursquare.get('venues/search', options)["groups"].detect { |group| group["type"] == name }
      response ? response["items"].map do |json|
        Foursquare::Venue.new(@foursquare, json)
      end : []
    end
  end
end
