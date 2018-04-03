# require 'json'
# require_relative './../../config/constants'
# require_relative './../../config/errors'
# require_relative 'coupon_types/bogo'
# require_relative 'coupon_types/discount'
# require_relative 'coupon_types/percentage'
# require_relative 'coupon_types/discount_cashback'

class CouponTypeInstanceParser

  def initialize(coupon_code)
    @coupon_code = coupon_code
  end

  def instance
    @coupon_hash = all_coupons.find{|coupon| coupon["code"] == @coupon_code}
    raise Errors::COUPON_CODE_INVALID unless @coupon_hash
    klass = Object.const_get("CouponTypes::#{coupon_type}")
    klass.new(@coupon_hash)
  end

  def all_coupons
    begin
      @all_coupons ||= JSON.parse(File.read(Constants::COUPON_CODES_STORE_PATH))["coupon_codes"]
    rescue
      load_coupon_codes_through_rake
      all_coupons
    end
  end

  private

    def coupon_type
      @coupon_hash["type"].gsub('&','')
    end

    def load_coupon_codes_through_rake
      rake = Rake.application
      rake.init
      rake.load_rakefile
      rake[Constants::COUPON_CODE_DOWNLOAD_TASK].invoke()
    end

end
