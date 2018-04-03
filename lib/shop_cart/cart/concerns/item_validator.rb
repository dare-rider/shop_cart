# require_relative './../../../config/errors'

module Cart
  module ItemValidator

    def validate
      raise Errors::CART_ITEM_INVALID unless
        @item_hash.is_a?(Hash) &&
        @item_hash["product_id"].is_a?(Fixnum) &&
        @item_hash["quantity"].is_a?(Fixnum) &&
        @item_hash["unit_cost"].is_a?(Fixnum)

    end
  end
end
