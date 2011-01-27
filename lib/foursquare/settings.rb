module Foursquare
  class Settings
    def initialize(foursquare, json={})
      @foursquare, @json = foursquare, json
    end

    def fetch
      @json = @foursquare.get('settings/all')["settings"]
    end

    def receive_pings?
      fetch unless @json.has_key?('receivePings')
      @json['receivePings']
    end

    def receive_comment_pings?
      fetch unless @json.has_key?('receiveCommentPings')
      @json['receiveCommentPings']
    end

    def send_to_twitter?
      fetch unless @json.has_key?('sendToTwitter')
      @json['sendToTwitter']
    end

    def send_to_facebook?
      fetch unless @json.has_key?('sendToFacebook')
      @json['sendToFacebook']
    end
  end
end
