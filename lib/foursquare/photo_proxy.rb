
require 'net/http/post/multipart'

module Foursquare
  class PhotoProxy

    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::Photo.new(@foursquare, @foursquare.get("photos/#{id}")["photo"])
    end

    def create(image_data, options={})
      options.merge!({
        :file => UploadIO.new(StringIO.new(image_data), 'image/jpeg', 'image.jpg')
      })
      if json = @foursquare.post_multipart("photos/add", options)
        p = Foursquare::Photo.new(@foursquare, json["photo"])
      else
        nil
      end
    end
    alias_method :add, :create

    def update(id, options={})
    end
    
    def destroy(id)
    end
    
  end
end
