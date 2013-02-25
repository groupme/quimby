# https://developer.foursquare.com/docs/responses/venue.html

module Foursquare
  class Location
    include JsonMethods
    
    # this enabled the previous app to work with this new version where Location is now an object
    def [](key)
      @json[key]
    end
    
    def initialize(json)
      @json = json
    end
  end
end
