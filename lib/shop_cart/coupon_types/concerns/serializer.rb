module CouponTypes

  module Serializer

    def serialize
      @coupon_hash.each do|key, value|
        define_singleton_method(key, ->{return value})
      end
    end

  end
end
