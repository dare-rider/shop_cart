# require_relative "cart/full_cart"
# require_relative "coupon_type_instance_parser"
# require_relative "./../../config/constants.rb"

class Discount

  def initialize(cart_items, coupon_code, outlet_id)
    @cart_items = cart_items
    @coupon_code = coupon_code
    @outlet_id = outlet_id
  end

  def apply
    begin
      cart = Cart::FullCart.new(@cart_items, @outlet_id)
      coupon_type = CouponTypeInstanceParser.new(@coupon_code).instance
      discount, cashback = coupon_type.apply_discount(cart)
      return success_result(discount, cashback)
    rescue Exception => e
      return error_result(e.message)
    end
  end

  private

    def success_result(discount, cashback)
      {
        "valid": true,
        "message": Constants::COUPON_APPLIED_STRING,
        "discount": discount,
        "cashback": cashback
      }
    end

    def error_result(error_message)
      {
        "valid": false,
        "message": error_message,
        "discount": 0,
        "cashback": 0
      }
    end
end
