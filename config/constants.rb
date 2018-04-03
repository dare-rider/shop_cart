class Constants

  GIST_BASE_PATH           = "https://gist.githubusercontent.com/mntdamania/"
  COUPON_CODES_REMOTE_PATH = "9a74afefbbc7e853fb84146d3c81676d/raw/0ae8aa2846dcf1fadb02dc605126e9ea3b8676ae/coupon_codes.json"
  COUPON_CODES_STORE_PATH  = "json/coupon_codes.json"
  CART_ITEMS_STORE_PATH    = "json/cart_items.json"
  COUPON_TYPES             = ["Discount", "Percentage", "Discount&Cashback", "Bogo"]
  COUPON_CODE_DOWNLOAD_TASK= "json:coupon_codes"
  COUPON_CODE_DOWNLOAD_MSG = "Downloading coupon codes through rake json:coupon_codes ....."
  COUPON_APPLIED_STRING    = "Coupon applied"

end
