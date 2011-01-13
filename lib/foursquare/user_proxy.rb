module Foursquare
  class UserProxy
    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::User.new(@foursquare, @foursquare.get("users/#{id}")["user"])
    end
  end
end
