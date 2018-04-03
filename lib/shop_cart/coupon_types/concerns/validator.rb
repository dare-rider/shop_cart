# require 'date'
# require_relative "./../../../../config/errors"
# require_relative "./../../../../config/constants"
# require_relative "coupon_hash_validator"

module CouponTypes

  module Validator

    include CouponTypes::CouponHashValidator

    def validate_coupon(outlet_id)
      currently_active? && applicable_for_today? && applicable_on_outlet?(outlet_id)
    end

    def validate_delivery_amount(delivery_amount)
      raise "#{Errors::DELIVERY_AMOUNT_LESS} #{minimum_delivery_amount_after_discount}" if delivery_amount < minimum_delivery_amount_after_discount
      true
    end

    private

      def currently_active?
        raise Errors::COUPON_INACTIVE unless active
        active
      end

      def applicable_for_today?
        applicable_today = Date.parse(start_date) <= Date.today && Date.parse(end_date) >= Date.today
        raise Errors::COUPON_NOT_APPLICABLE_TODAY unless applicable_today
        applicable_today
      end

      def applicable_on_outlet?(outlet_id)
        outlet_applicable = applicable_outlet_ids.empty? || applicable_outlet_ids.include?(outlet_id)
        raise Errors::COUPON_NOT_APPLICABLE_ON_OUTLET unless outlet_applicable
        outlet_applicable
      end

  end
end
