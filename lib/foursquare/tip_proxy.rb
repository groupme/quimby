module Foursquare
  class TipProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def search(options={})
      @foursquare.get("tips/search", options)["tips"].map do |tip|
        Foursquare::Tip.new(@foursquare, tip)
      end
    end
  end
end