describe CouponTypes::DiscountCashback do
  let(:coupon_hash) {
    {
      "id" => 3,
      "code" => "GETCASHBACK",
      "type" => "Discount&Cashback",
      "value" => 150,
      "cashback_value" => 150,
      "start_date" => "2015-07-01",
      "end_date" => "2019-12-31",
      "active" => true,
      "applicable_outlet_ids" => [],
      "minimum_delivery_amount_after_discount" => 200,
      "maximum_discount" => 150
    }
  }

  let(:items_arr) { [
      {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 },
      {"product_id" => 2, "quantity" => 1, "unit_cost" => 200 }
    ] }

  let(:outlet_id) { 1 }

  let(:cart) { Cart::FullCart.new(items_arr, outlet_id) }

  subject(:discount_cashback) { described_class.new(coupon_hash) }

  describe '.calculate_discount' do
    context 'discount value less than maximum_discount' do
      it 'must return discount value' do
        expect( discount_cashback.calculate_discount(cart) ).to eq(coupon_hash["value"])
      end
    end

    context 'discount value greater than maximum_discount' do
      it 'must return maximum_discount' do
        coupon_hash["value"] = 250
        expect( discount_cashback.calculate_discount(cart) ).to eq(coupon_hash["maximum_discount"])
      end
    end
  end

  describe '.calculate_cashback' do
    context 'cashback' do
      it 'must return same as cashback_value' do
        expect( discount_cashback.calculate_cashback(cart) ).to eq(coupon_hash["cashback_value"])
      end
    end
  end
end
