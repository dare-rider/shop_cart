# require_relative 'concerns/base'
# require_relative './../../../config/errors'

module CouponTypes
  class Bogo

    include CouponTypes::Base

    def calculate_discount(cart)
      @items_with_quantity_gt_1 = cart.items_with_quantity_gt_1
      if @items_with_quantity_gt_1.any?
        return [bogo_multi_quantity_discount, maximum_discount].min
      else
        return [bogo_single_qunatity_discount(cart), maximum_discount].min
      end
    end

    def calculate_cashback(cart)
      0
    end

    private

      def bogo_multi_quantity_discount
        item_specific_discount = @items_with_quantity_gt_1.map do|item|
                                    if item.quantity % 2 == 0
                                      item.quantity * item.unit_cost / 2
                                    else
                                      (item.quantity - 1) * item.unit_cost / 2
                                    end
                                  end
        return item_specific_discount.max
      end

      def bogo_single_qunatity_discount(cart)
        raise Errors::CANNOT_APPLY_BOGO_DISCOUNT unless cart.items.length > 1
        return cart.items.map{|item| item.unit_cost}.min
      end

  end
end
