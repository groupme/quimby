module Foursquare
  class Icon
    
    def initialize(json)
      @json = json
    end
    
    def prefix
      @json['prefix']
    end
    
    def name
      @json['name']
    end
    
    def sizes
      @json['sizes']
    end
    
    def url(size = nil)
      size = sizes.first unless size
      "#{prefix}#{size}#{name}"
    end
    
    # default
    def self.venue
      new({"prefix" => "https://foursquare.com/img/categories/none_", "sizes" => [32,44,64,88,256], "name" => ".png"})
    end
    
  end
end