# require_relative 'item'
# require_relative 'concerns/validator'
# require_relative 'concerns/serializer'

module Cart

  class FullCart
    attr_reader :items, :outlet_id

    include Cart::Validator, Cart::Serializer

    def initialize(items_arr, outlet_id)
      validate(items_arr)
      @items = items_arr.map{|item| Cart::Item.new(item)}
      @outlet_id = outlet_id
    end

  end

end
