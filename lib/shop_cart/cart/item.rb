# require_relative "concerns/item_serializer"

module Cart
  class Item
    include Cart::ItemSerializer

    def initialize(item_hash)
      @item_hash = item_hash
      serialize
    end

  end
end
