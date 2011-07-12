module Foursquare
  class Client < API

    private
    def valid_date_string
      Time.new.strftime("%Y%m%d")
    end
  end
end
