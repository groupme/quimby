module Foursquare
  class Badge
    attr_reader :json

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def unlocked
      !@json[1]["unlocks"].empty?
    end

    def id
      @json[0]
    end

    def name
      @json[1]["name"]
    end

    def hint
      @json[1]["hint"]
    end

    def description
      @json[1]["description"]
    end


    def images
      @json[1]["image"]["sizes"].map{|size| @json[1]["image"]["prefix"]+size.to_s+@json[1]["image"]["name"] }
    end

    def image
      images.first
    end

  end
end
