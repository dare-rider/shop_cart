module Cart

  module ItemSerializer

    def serialize
      @item_hash.each do|key, value|
        define_singleton_method(key, ->{return value})
      end
    end

  end

end
