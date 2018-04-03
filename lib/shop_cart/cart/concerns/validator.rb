# require_relative './../../../config/errors'

module Cart
  module Validator

    def validate(items_arr)
      raise Errors::CART_INVALID unless items_arr.is_a?(Array)
      raise Errors::CART_EMPTY unless items_arr.any?
    end

  end
end
