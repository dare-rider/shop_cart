describe CouponTypeInstanceParser do

  let(:coupon_code) { "BOX8LOVE" }
  subject(:parser) { described_class.new(coupon_code) }

  describe '.instance' do
    context 'invalid coupon code' do
      it 'raises RunTime Exception for invalid code' do
        coupon_code = "ABC"
        expect { described_class.new(coupon_code).instance }.to raise_exception(RuntimeError, Errors::COUPON_CODE_INVALID)
      end
    end

    context 'valid coupon code' do
      it 'return Percentage instance if coupon code is of type Percentage' do
        expect( parser.instance ).to be_a CouponTypes::Percentage
      end

      it 'return Bogo instance if coupon code is of type Bogo' do
        coupon_code = "BOGO"
        expect( described_class.new(coupon_code).instance ).to be_a CouponTypes::Bogo
      end

      it 'return DiscountCashback instance if coupon code is of type Discount&Cashback' do
        coupon_code = "GETCASHBACK"
        expect( described_class.new(coupon_code).instance ).to be_a CouponTypes::DiscountCashback
      end

      it 'return Discount instance if coupon code is of type Discount' do
        coupon_code = "HELLOBOX8"
        expect( described_class.new(coupon_code).instance ).to be_a CouponTypes::Discount
      end
    end
  end
end
