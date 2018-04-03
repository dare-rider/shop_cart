describe CouponTypes::Bogo do
  let(:coupon_hash) {
    {
      "id" => 4,
      "code" => "BOGO",
      "type" => "Bogo",
      "value" => 0,
      "cashback_value" => 0,
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

  subject(:bogo) { described_class.new(coupon_hash) }

  describe '.calculate_discount' do
    context 'cart not applicable for bogo discount' do
      it 'raises RunTime exception if only single item with quantity 1 is present in cart' do
        items_arr = [
          {"product_id" => 1, "quantity" => 1, "unit_cost" => 100 }
        ]
        expect{ bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) }.to raise_exception(Errors::CANNOT_APPLY_BOGO_DISCOUNT)
      end
    end

    context 'discount value less than maximum_discount' do
      it 'Case 1: (1-100 1-200) must return 100' do
        items_arr = [
          {"product_id" => 1, "quantity" => 1, "unit_cost" => 100 },
          {"product_id" => 2, "quantity" => 1, "unit_cost" => 200 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(100)
      end

      it 'Case 2: (2-100 1-200) must return 100' do
        expect( bogo.calculate_discount(cart) ).to eq(100)
      end

      it 'Case 3: (1-100 2-130) must return 130' do
        items_arr = [
          {"product_id" => 1, "quantity" => 1, "unit_cost" => 100 },
          {"product_id" => 2, "quantity" => 2, "unit_cost" => 130 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(130)
      end

      it 'Case 4: (2-100 2-130) must return 130' do
        items_arr = [
          {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 },
          {"product_id" => 2, "quantity" => 2, "unit_cost" => 130 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(130)
      end
    end

    context 'discount value greater than maximum_discount' do
      it 'Case 1: (1-300 1-400) must return maximum_discount' do
        items_arr = [
          {"product_id" => 1, "quantity" => 1, "unit_cost" => 300 },
          {"product_id" => 2, "quantity" => 1, "unit_cost" => 400 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(coupon_hash["maximum_discount"])
      end

      it 'Case 2: (1-100 2-200) must return maximum_discount' do
        items_arr = [
          {"product_id" => 1, "quantity" => 1, "unit_cost" => 100 },
          {"product_id" => 2, "quantity" => 2, "unit_cost" => 200 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(coupon_hash["maximum_discount"])
      end

      it 'Case 3: (2-100 2-200) must return maximum_discount' do
        items_arr = [
          {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 },
          {"product_id" => 2, "quantity" => 2, "unit_cost" => 200 }
        ]
        expect( bogo.calculate_discount(Cart::FullCart.new(items_arr, outlet_id)) ).to eq(coupon_hash["maximum_discount"])
      end
    end
  end

  describe '.calculate_cashback' do
    context 'valid/invalid cashback' do
      it 'must return 0 in any case' do
        coupon_hash["cashback_value"] = 100
        expect( bogo.calculate_cashback(cart) ).to eq(0)
      end
    end
  end
end
