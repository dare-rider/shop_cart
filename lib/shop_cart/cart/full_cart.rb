# require_relative 'item'
# require_relative 'concerns/serializer'

module Cart

  class FullCart
    attr_reader :items

    include Cart::Serializer

    def initialize(items_arr)
      @items = items_arr.map{|item| Cart::Item.new(item)}
    end

  end

end
