# https://developer.foursquare.com/docs/responses/venue.html

module Foursquare
  class Location
    
    def initialize(json)
      @json = json
    end
    
    def address
      @json["address"]
    end
    
    def cross_street
      @json["crossStreet"]
    end
    
    def city
      @json["city"]
    end
    
    def state
      @json["state"]
    end
    
    def postal_code
      @json["postalCode"]
    end
    
    def country
      @json["country"]
    end
    
    def lat
      @json["lat"]
    end
    
    def lng
      @json["lng"]
    end
    
    def distance
      @json["distance"]
    end
    
  end
end