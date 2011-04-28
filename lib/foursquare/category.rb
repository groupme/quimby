module Foursquare
  class Category
    
    # this enabled the previous app to work with this new version where Category is now an object
    def [](key)
      @json[key]
    end
    
    def initialize(json)
      @json = json
    end
    
    def name
      @json["name"]
    end
    
    def plural_name
      @json["pluralName"]
    end
    
    def icon
      @json["icon"]
    end
    
    # array
    def parents
      @json["parents"]
    end
    
    def primary?
      @json["primary"] == true
    end
    
  end
end