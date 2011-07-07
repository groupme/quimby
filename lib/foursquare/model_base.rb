module Foursquare
  class ModelBase
    attr_reader :json

    include JsonMethods

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def fetch
      @json = @foursquare.get("#{self.class.pluralize}/#{id}")[self.class]
      self
    end
  end
end
