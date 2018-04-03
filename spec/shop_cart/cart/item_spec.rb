describe Cart::Item do
  let(:item_hash) { {"product_id" => 1, "quantity" => 2, "unit_cost" => 100 } }
  subject(:item) { described_class.new(item_hash) }

  describe '.new' do
    context 'item_hash not valid' do
      it 'raises RunTime Exception for empty hash' do
        item_hash = {}
        expect { described_class.new(item_hash) }.to raise_exception(RuntimeError, Errors::CART_ITEM_INVALID)
      end

      it 'raises RunTime Exception for any missing key' do
        item_hash = {"product_id" => 1, "quantity" => 2}
        expect { described_class.new(item_hash) }.to raise_exception(RuntimeError, Errors::CART_ITEM_INVALID)
      end

      it 'raises RunTime Exception for invalid data' do
        item_hash = {"product_id" => 1, "quantity" => 2, "unit_cost" => "100"}
        expect { described_class.new(item_hash) }.to raise_exception(RuntimeError, Errors::CART_ITEM_INVALID)
      end
    end

    context 'item_hash valid' do
      it 'does not raise any exception' do
        expect { item }.to_not raise_exception
      end
    end
  end
end
