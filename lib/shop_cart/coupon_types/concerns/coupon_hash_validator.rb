# require_relative "./../../../../config/errors"
# require_relative "./../../../../config/constants"

module CouponTypes
  module CouponHashValidator

    def validate_coupon_hash
      raise Errors::COUPON_HASH_INVALID unless
        @coupon_hash.is_a?(Hash) &&
        Constants::COUPON_TYPES.include?(@coupon_hash["type"]) &&
        @coupon_hash["value"].is_a?(Fixnum) &&
        @coupon_hash["cashback_value"].is_a?(Fixnum) &&
        @coupon_hash["start_date"].is_a?(String) &&
        @coupon_hash["end_date"].is_a?(String) &&
        [true, false].include?(@coupon_hash["active"]) &&
        @coupon_hash["applicable_outlet_ids"].is_a?(Array) &&
        @coupon_hash["minimum_delivery_amount_after_discount"].is_a?(Fixnum) &&
        @coupon_hash["maximum_discount"].is_a?(Fixnum)
    end

  end
end
