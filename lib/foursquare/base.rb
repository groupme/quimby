module Foursquare
  class Base
    API = "https://api.foursquare.com/v2/"

    def initialize(*args)
      case args.size
      when 1
        @access_token = args.first
      when 2
        @client_id, @client_secret = args
      else
        raise ArgumentError, "You need to pass either an access_token or client_id and client_secret"
      end
    end

    def users
      Foursquare::UserProxy.new(self)
    end

    def checkins
      Foursquare::CheckinProxy.new(self)
    end

    def venues
      Foursquare::VenueProxy.new(self)
    end

    def settings
      @settings ||= Foursquare::Settings.new(self)
    end

    def get(path, params={})
      params = camelize(params)
      Foursquare.log("GET #{API + path}")
      Foursquare.log("PARAMS: #{params.inspect}")
      merge_auth_params(params)
      response = JSON.parse(Typhoeus::Request.get(API + path, :params => params).body)
      Foursquare.log(response.inspect)
      error(response) || response["response"]
    end

    def post(path, params={})
      params = camelize(params)
      Foursquare.log("POST #{API + path}")
      Foursquare.log("PARAMS: #{params.inspect}")
      merge_auth_params(params)
      response = JSON.parse(Typhoeus::Request.post(API + path, :params => params).body)
      Foursquare.log(response.inspect)
      error(response) || response["response"]
    end

    private

    def camelize(params)
      params.inject({}) { |o, (k, v)|
        o[k.to_s.gsub(/(_[a-z])/) { |m| m[1..1].upcase }] = v
        o
      }
    end

    def error(response)
      case response["meta"]["errorType"]
      when nil
        # It's all good.
      when "deprecated"
        Foursquare.log(Foursquare::ERRORS[response['meta']['errorType']])
        nil
      else
        raise Foursquare::Error.new(Foursquare::ERRORS[response['meta']['errorType']])
      end
    end

    def merge_auth_params(params)
      if @access_token
        params.merge!(:oauth_token => @access_token)
      else
        params.merge!(:client_id => @client_id, :client_secret => @client_secret)
      end
    end
  end
end
