module Foursquare
  class ListProxy

    def initialize(foursquare)
      @foursquare = foursquare
    end

    def find(id)
      Foursquare::List.new(@foursquare, @foursquare.get("lists/#{id}")["list"])
    end

    def create(options={})
      debugger
      if json = @foursquare.post("lists/add", options)
        Foursquare::List.new(@foursquare, json["list"])
      else
        nil
      end
    end
    alias_method :add, :create

    def update(id, options={})
      if json = @foursquare.post("lists/#{id}/update", options)
        Foursquare::List.new(@foursquare, json["list"])
      else
        nil
      end
    end
    
    def destroy(id)
    end
    
    def add_item(id, options={})
      if json = @foursquare.post("lists/#{id}/additem", options)
        Foursquare::List.new(@foursquare, json["list"])
      else
        nil
      end      
    end
    
    def user_add_done_item(user_id, options={})
      puts @foursquare
      if json = @foursquare.post("lists/#{user_id}/dones/additem", options)
        Foursquare::List.new(@foursquare, json["list"])
      else
        nil
      end      
    end

    def delete_item(id, options={})
      if json = @foursquare.post("lists/#{id}/deleteitem", options)
        Foursquare::List.new(@foursquare, json["list"])
      else
        nil
      end      
    end

  end
end