require 'json'
require 'date'
require 'rake'

require_relative './../config/errors'
require_relative './../config/constants'

require 'shop_cart/cart/concerns/item_validator'
require 'shop_cart/cart/concerns/item_serializer'
require 'shop_cart/cart/concerns/validator'
require 'shop_cart/cart/concerns/serializer'
require 'shop_cart/cart/item'
require 'shop_cart/cart/full_cart'

require 'shop_cart/coupon_types/concerns/coupon_hash_validator'
require 'shop_cart/coupon_types/concerns/serializer'
require 'shop_cart/coupon_types/concerns/validator'
require 'shop_cart/coupon_types/concerns/base'
require 'shop_cart/coupon_types/bogo'
require 'shop_cart/coupon_types/discount'
require 'shop_cart/coupon_types/percentage'
require 'shop_cart/coupon_types/discount_cashback'

require 'shop_cart/coupon_type_instance_parser'



