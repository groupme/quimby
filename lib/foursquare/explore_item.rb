module Foursquare
  class ExploreItem
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def reasons
      @json['reasons']['items']
    end
    
    def venue
      @venue ||= Foursquare::Venue.new(@foursquare, @json['venue'])
    end
    
    def tips
      @tips ||= @json["tips"].map do |tip|
        Foursquare::Tip.new(@foursquare, tip)
      end
    end
    
  end
end