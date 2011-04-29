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
    
    def authorize_url(redirect_uri)
      # http://developer.foursquare.com/docs/oauth.html
      
      # check params
      raise "you need to define a client id before" if @client_id.blank?
      raise "no callback url provided" if redirect_uri.blank?
      
      # params
      params = {}
      params["client_id"] = @client_id
      params["response_type"] = "code"
      params["redirect_uri"] = redirect_uri
      
      # url
      oauth2_url('authenticate', params)
    end
    
    def access_token(code, redirect_uri)
      # http://developer.foursquare.com/docs/oauth.html
      
      # check params
      raise "you need to define a client id before" if @client_id.blank?
      raise "you need to define a client secret before" if @client_secret.blank?
      raise "no code provided" if code.blank?
      raise "no redirect_uri provided" if redirect_uri.blank?
      
      # params
      params = {}
      params["client_id"] = @client_id
      params["client_secret"] = @client_secret
      params["grant_type"] = "authorization_code"
      params["redirect_uri"] = redirect_uri
      params["code"] = code
      
      # url
      url = oauth2_url('access_token', params)
      
      # response
      # http://developer.foursquare.com/docs/oauth.html
      response = JSON.parse(Typhoeus::Request.get(url).body)
      response["access_token"]
    end

    private
    
    def oauth2_url(method_name, params)
      "https://foursquare.com/oauth2/#{method_name}?#{params.to_query}"
    end

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
        error_type = response['meta']['errorType']
        case error_type
        when "invalid_auth"
          raise Foursquare::InvalidAuth.new(Foursquare::ERRORS[error_type])
        when "server_error"
          raise Foursquare::ServiceUnavailable.new(Foursquare::ERRORS[error_type])
        else
          raise Foursquare::Error.new(Foursquare::ERRORS[error_type])
        end
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
