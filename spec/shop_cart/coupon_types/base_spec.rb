describe "Coupon Hash Validator" do
  let(:coupon_hash) {
    {
      "id" => 1,
      "code" => "BOX8LOVE",
      "type" => "Percentage",
      "value" => 10,
      "cashback_value" => 0,
      "start_date" => "2015-07-01",
      "end_date" => "2019-12-31",
      "active" => true,
      "applicable_outlet_ids" => [],
      "minimum_delivery_amount_after_discount" => 150,
      "maximum_discount" => 200
    }
  }


  let(:items_arr) { [
      {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 },
      {"product_id" => 2, "quantity" => 1, "unit_cost" => 200 }
    ] }

  let(:outlet_id) { 1 }

  let(:cart) { Cart::FullCart.new(items_arr, outlet_id) }

  subject(:coupon_type) { CouponTypes::Discount.new(coupon_hash) }

  describe '.new' do
    context 'invalid coupon hash' do
      it 'raise RunTime Exception for any other coupon type' do
        coupon_hash["type"] = "ABC"
        expect { CouponTypes::Discount.new(coupon_hash) }.to raise_exception(RuntimeError, Errors::COUPON_HASH_INVALID)
      end

      it 'raise RunTime Exception for any missing key' do
        coupon_hash["applicable_outlet_ids"] = nil
        expect { CouponTypes::Discount.new(coupon_hash) }.to raise_exception(RuntimeError, Errors::COUPON_HASH_INVALID)
      end
    end

    context 'valid coupon hash' do
      it 'does not raise any exception' do
        expect { CouponTypes::Discount.new(coupon_hash) }.to_not raise_exception
      end
    end
  end

  describe '.apply_discount' do
    context 'validate_coupon' do
      it 'raises RunTime exception for inactive coupons' do
        coupon_hash["active"] = false
        expect{ CouponTypes::Discount.new(coupon_hash).apply_discount(cart) }.to raise_exception(RuntimeError, Errors::COUPON_INACTIVE)
      end

      it 'raises RunTime exception if not applicable for today' do
        coupon_hash["end_date"] = "2017-12-31"
        expect{ CouponTypes::Discount.new(coupon_hash).apply_discount(cart) }.to raise_exception(RuntimeError, Errors::COUPON_NOT_APPLICABLE_TODAY)
      end

      it 'raises RunTime exception if not applicable on the outlet' do
        coupon_hash["applicable_outlet_ids"] = [3, 4]
        expect{ CouponTypes::Discount.new(coupon_hash).apply_discount(cart) }.to raise_exception(RuntimeError, Errors::COUPON_NOT_APPLICABLE_ON_OUTLET)
      end

      it 'raises RunTime exception if not applicable on the outlet' do
        coupon_hash["minimum_delivery_amount_after_discount"] = 400
        expect{ CouponTypes::Discount.new(coupon_hash).apply_discount(cart) }.to raise_exception(RuntimeError, "#{Errors::DELIVERY_AMOUNT_LESS} #{coupon_hash['minimum_delivery_amount_after_discount']}")
      end

      it 'raises no exception for the given input' do
        expect{ coupon_type.apply_discount(cart) }.to_not raise_exception
      end

    end
  end
end
