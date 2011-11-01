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
      #options = options.merge({:v => "20110910"}) unless options[:v]
      puts options
      response = @foursquare.get('venues/search', options)["venues"].map do |json|
        Foursquare::Venue.new(@foursquare, json)
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
    
    def managed
      venues = []
      response = @foursquare.get('venues/managed')["venues"].each do |json|
        venues << Foursquare::Venue.new(@foursquare, json)
      end                                                
      venues
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
