# require_relative "concerns/item_validator"
# require_relative "concerns/item_serializer"

module Cart

  class Item

    include Cart::ItemValidator, Cart::ItemSerializer

    def initialize(item_hash)
      @item_hash = item_hash
      validate
      serialize
    end

  end
end
