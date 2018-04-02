# require_relative 'serializer'
# require_relative 'validator'

module CouponTypes

  module Initializer

    # must override calculate_discount(cart_items) or calculate_cashback(cart_items) in respective class

    include CouponTypes::Serializer, CouponTypes::Validator

    def initialize(coupon_hash)
      @coupon_hash = coupon_hash
      serialize
    end

    def apply_discount(cart, outlet_id)
      validate_coupon(outlet_id)
      discount = calculate_discount(cart)
      cashback = calculate_cashback(cart)
      delivery_amount = cart.total - discount
      validate_delivery_amount(delivery_amount)
      return discount, cashback
    end

    # Default methods

    def calculate_discount(cart)
      [value, maximum_discount].min
    end

    def calculate_cashback(cart)
      cashback_value
    end

  end
end
