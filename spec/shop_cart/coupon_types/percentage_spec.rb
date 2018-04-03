describe CouponTypes::Percentage do
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

  subject(:percentage) { described_class.new(coupon_hash) }

  describe '.calculate_discount' do
    context 'discount value less than maximum_discount' do
      it 'must return discounted amount' do
        expect( percentage.calculate_discount(cart) ).to eq(40)
      end
    end

    context 'discount value greater than maximum_discount' do
      it 'must return maximum_discount' do
        coupon_hash["value"] = 80
        expect( percentage.calculate_discount(cart) ).to eq(coupon_hash["maximum_discount"])
      end
    end
  end

  describe '.calculate_cashback' do
    context 'valid/invalid cashback' do
      it 'must return 0 in any case' do
        coupon_hash["cashback_value"] = 100
        expect( percentage.calculate_cashback(cart) ).to eq(0)
      end
    end
  end
end
