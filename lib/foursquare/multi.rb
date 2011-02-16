module Foursquare
  class Multi
    def initialize(foursquare, block)
      @foursquare = foursquare
      @requests = []
      @responses = []
    end

    def get(path, options={})
      @requests << path + query(params)
    end

    def perform
      responses = @foursquare.get("multi", :requests => @requests.join(','))
    end

    private

    def query(params)
      camelized = params.inject({}) { |o, (k, v)|
        o[k.to_s.gsub(/(_[a-z])/) { |m| m[1..1].upcase }] = v
        o
      }
      camelized.inject([]) { |o, (k, v)|
        o << CGI.escape(k) + "=" CGI.escape(v)
        o
      }.join('&')
    end
  end
end
