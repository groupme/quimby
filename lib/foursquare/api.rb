module Foursquare
  class API < Base
    def initialize(options = {})
      @api = options.delete(:url) || "https://api.foursquare.com/v2/"
      @auth = options.delete(:auth)
      unless @auth
        raise ArgumentError, "A username and password, access_token, or client_id and client_secret are required"
      end
    end
  end
end
