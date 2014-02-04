module Foursquare
  class CheckinComment
    attr_reader :json

    def initialize(foursquare, json)
      @foursquare, @json = foursquare, json
    end

    def id
      @json["id"]
    end

    def created_at
      Time.at(@json["createdAt"].to_i)
    end

    def text
      @json["text"]
    end

    def user(full=false)
      if full
        @foursquare.users.find(@json["user"]["id"])
      else
        Foursquare::User.new(@foursquare, @json["user"])
      end
    end
  end
end
