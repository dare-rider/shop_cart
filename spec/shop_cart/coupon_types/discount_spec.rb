describe CouponTypes::Discount do
  let(:coupon_hash) {
    {
      "id" => 2,
      "code" => "HELLOBOX8",
      "type" => "Discount",
      "value" => 100,
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

  subject(:discount) { described_class.new(coupon_hash) }

  describe '.calculate_discount' do
    context 'discount value less than maximum_discount' do
      it 'must return discount value' do
        expect( discount.calculate_discount(cart) ).to eq(coupon_hash["value"])
      end
    end

    context 'discount value greater than maximum_discount' do
      it 'must return maximum_discount' do
        coupon_hash["value"] = 400
        expect( discount.calculate_discount(cart) ).to eq(coupon_hash["maximum_discount"])
      end
    end
  end

  describe '.calculate_cashback' do
    context 'valid/invalid cashback' do
      it 'must return 0 in any case' do
        coupon_hash["cashback_value"] = 100
        expect( discount.calculate_cashback(cart) ).to eq(0)
      end
    end
  end
end
