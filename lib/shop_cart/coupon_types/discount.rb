# require_relative 'concerns/base'

module CouponTypes
  class Discount
    include CouponTypes::Base

    def calculate_cashback(cart)
      0
    end
  end
end
