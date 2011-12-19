module Foursquare
  class ListProxy
    
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::List.new(@foursquare, @foursquare.get("lists/#{id}")["list"])
    end
    
  end
end