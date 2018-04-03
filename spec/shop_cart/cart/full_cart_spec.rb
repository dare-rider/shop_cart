describe Cart::FullCart do
  let(:items_arr) { [
      {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 },
      {"product_id" => 2, "quantity" => 1, "unit_cost" => 200 }
    ] }
  subject(:cart) { described_class.new(items_arr, 1) }

  describe '.new' do
    context 'cart not valid' do
      it 'raises RunTime Exception for invalid item_arr' do
        items_arr = {}
        expect { described_class.new(items_arr, 1) }.to raise_exception(RuntimeError, Errors::CART_INVALID)
      end

      it 'raises RunTime Exception for empty item_arr' do
        items_arr = []
        expect { described_class.new(items_arr, 1) }.to raise_exception(RuntimeError, Errors::CART_EMPTY)
      end
    end

    context 'cart is valid' do
      it 'does not raise any exception' do
        expect { cart }.to_not raise_exception
      end
    end
  end
end
