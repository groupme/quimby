module Foursquare
  class Client < API
    attr_accessor :configuration

    def initialize(options={})
      module_config = {}
      Foursquare::Configuration.valid_option_keys.each do |key|
        module_config[key] = Foursquare.configuration.send(key.to_s)
      end
      @configuration = Foursquare::Configuration.new(
        module_config.merge(options))
    end

    def venue_categories
      response = get("venues/categories")
      response["categories"]
    end

    def create_special(options={})
      response = post("specials/add", options)
      response["special"]
    end

    private
    def get(path, params={})
      params = camelize(params)
      request_uri = URI.parse(self.configuration.endpoint + path).to_s
      request_params = params_including_auth(request_uri, params)
      response_json = Typhoeus::Request.get(request_uri, request_params)
      response = JSON.parse(response_json.body)
      Foursquare.log("GET #{request_uri}")
      Foursquare.log("PARAMS: #{params.inspect}")
      Foursquare.log("RESPONSE: \n#{response.inspect}\n")
      error(response) || response["response"]
    end

    def post(path, params={})
      endpoint = self.configuration.endpoint + path
      params = camelize(params)
      req_url = URI.parse(endpoint).to_s
      req_params = params_including_auth(req_url, params)
      resp_json = Typhoeus::Request.post(req_url, req_params)
      response = JSON.parse(resp_json.body)
      Foursquare.log("POST: #{req_url}")
      Foursquare.log("PARAMS: #{params.inspect}")
      Foursquare.log("RESPONSE: \n#{response.inspect}\n")
      error(response) || response["response"]
    end

    def params_including_auth(request_uri, params)
      new_params = {:params => params}
      oauth_keys = [:oauth_token,
                    :oauth_consumer_key,
                    :oauth_consumer_secret]
      oauth_keys.each do |key|
        val = configuration.send(key.to_s)
        new_params[:params][key] = val if val
      end
      if request_uri.match(/staging/)
        basic_auth_keys = [:http_username, :http_password]
        basic_auth_keys.each do |key|
          val = configuration.send(key.to_s)
          new_params[key] = val if val
        end
      end
      new_params.merge(:v => valid_date_string)
    end

    def valid_date_string
      Time.new.strftime("%Y%m%d")
    end
  end
end
