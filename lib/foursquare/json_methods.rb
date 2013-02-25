module Foursquare
  module JsonMethods

    # Catch initial top level json key names as methods
    def method_missing(sym, *args, &block)
      method_split = sym.to_s.split('_')
      
      if method_split.length == 1
        method_name = method_split.first 
      else
        method_name = "#{method_split.first}#{method_split[1,].map(&:titleize).join}"
      end

      if @json && @json.has_key?(method_name)
        @json[method_name]
      else
        super(sym, args, block)
      end
    end

  end
end
