# require_relative 'concerns/base'

module CouponTypes
  class Percentage

    include CouponTypes::Base

    def calculate_discount(cart)
      discount_value = value * cart.total/100
      [discount_value, maximum_discount].min
    end

    def calculate_cashback(cart)
      0
    end

  end
end
