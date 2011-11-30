module Foursquare
  class ExploreResult
    
    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end
    
    def keywords
      @json['keywords']['items']
    end
    
    def groups
      hash = {}
      @json['groups'].collect do |group|
        h = {}
        h['name'] = group['name']
        h['items'] = group['items'].collect! do |item|
          Foursquare::ExploreItem.new(@foursquare, item)
        end
        hash[group['type']] = h
      end
      hash
    end
    
  end
end