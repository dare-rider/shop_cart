require 'json'
require 'date'
require 'rake'
require_relative './../config/constants'
require_relative './../config/errors'

require_relative 'shop_cart/cart/concerns/item_serializer'
require_relative 'shop_cart/cart/concerns/serializer'
require_relative 'shop_cart/cart/item'
require_relative 'shop_cart/cart/full_cart'

require_relative 'shop_cart/coupon_types/concerns/serializer'
require_relative 'shop_cart/coupon_types/concerns/validator'
require_relative 'shop_cart/coupon_types/concerns/initializer'
require_relative 'shop_cart/coupon_types/bogo'
require_relative 'shop_cart/coupon_types/discount'
require_relative 'shop_cart/coupon_types/percentage'
require_relative 'shop_cart/coupon_types/discount_cashback'

require_relative 'shop_cart/coupon_type_instance_parser'
require_relative 'shop_cart/discount'



def apply_discount(cart_items, coupon_code, outlet_id)
  return Discount.new(cart_items, coupon_code, outlet_id).apply
end

cart_items = JSON.parse(File.read(Constants::CART_ITEMS_STORE_PATH))["cart_items"]

puts apply_discount(cart_items, "BOX8LOVE", 1)
