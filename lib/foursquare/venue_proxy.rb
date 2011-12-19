module Foursquare
  class VenueProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    # find a specific venue given an id
    # https://developer.foursquare.com/docs/venues/venues.html
    def find(id)
      raise ArgumentError, "You must include a venueId" if id.blank?
      
      Foursquare::Venue.new(@foursquare, @foursquare.get("venues/#{id}")["venue"])
    end
    
    # returns all categories
    # https://developer.foursquare.com/docs/venues/categories.html
    def categories
      @foursquare.get('venues/categories')['categories']
    end
    
    # explore
    # https://developer.foursquare.com/docs/venues/explore.html
    def explore(options = {})
      Foursquare::ExploreResult.new @foursquare, @foursquare.get('venues/explore', options)
    end
    
    # https://developer.foursquare.com/docs/venues/search.html
    def search(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]      
      @foursquare.get('venues/search', options)["venues"].map do |json|
        Foursquare::Venue.new(@foursquare, json)
      end
    end
    
    # get trending venues
    # https://developer.foursquare.com/docs/venues/trending.html
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
      
      @foursquare.get('venues/trending', options)["venues"].map do |json|
        Foursquare::Venue.new(@foursquare, json)
      end
    end
    
  end
end
