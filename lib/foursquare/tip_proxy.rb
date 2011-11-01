module Foursquare
  class TipProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Tip.new(@foursquare, @foursquare.get("tips/#{id}")["tip"])
    end
    
    def search(options={})
      raise ArgumentError, "You must include :ll" unless options[:ll]
      @foursquare.get("tips/search", options)["results"].map do |json|
        Foursquare::Tip.new(@foursquare, json)
      end
    end
    
    def create(options={})
      if json = @foursquare.post("tips/add", options)
        Foursquare::Tip.new(@foursquare, json["tip"])
      else
        nil
      end
    end
    alias_method :add, :create
    
  end
end