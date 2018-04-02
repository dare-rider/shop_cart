# require_relative 'concerns/initializer'

module CouponTypes
  class Percentage

    include CouponTypes::Initializer

    def calculate_discount(cart)
      discount_value = value * cart.total/100
      [discount_value, maximum_discount].min
    end

  end
end
