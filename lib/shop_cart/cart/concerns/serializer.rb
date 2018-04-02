module Cart

  module Serializer

    def total
      @total ||= @items.inject(0){|acc, item| acc + item.quantity * item.unit_cost}
    end

    def items_with_quantity_gt_1
      @items.select{|item| item.quantity > 1}
    end

  end
end
