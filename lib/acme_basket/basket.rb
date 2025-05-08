# frozen_string_literal: true

module AcmeBasket
  # This class represents a shopping basket that can hold products,
  # apply offers and calculate the total cost including delivery charge.
  class Basket
    def initialize(catalogue: Catalogue::WidgetCatalogue.new,
                   delivery_rule: DeliveryRule::WidgetCharge.new,
                   offers: [])
      @catalogue = catalogue
      @delivery_rule = delivery_rule
      @offers = offers
      @items = []
    end

    def add(code, quantity = 1)
      enforce_valid_quantity(quantity)

      product = @catalogue.find(code)
      raise "Unknown product: #{code}" unless product

      quantity.times { @items << product }
    end

    def remove(code, quantity = 1)
      enforce_valid_quantity(quantity)

      count = @items.count { |p| p.code == code }
      quantity_to_remove = [quantity, count].min
      quantity_to_remove.times do
        item_index = @items.find_index { |p| p.code == code }
        @items.delete_at(item_index) if item_index
      end
    end

    def clear!
      @items.clear
    end

    def items
      @items.group_by(&:code).map do |code, group|
        {
          code: code,
          name: group.first.name,
          quantity: group.size
        }
      end
    end

    def total
      # Because it is not fair if we still charge delivery when cart is empty
      return 0.0 if @items.empty?

      # Round down to 2 decimal places.
      # This means that the shop bears the cost (less than a cent)
      # of rounding, to avoid confusion for customers.
      ((total_after_discount + delivery_charge) * 100).floor / 100.0
    end

    private

    def subtotal
      @items.sum(&:price)
    end

    def discount
      # TODO: apply rules here
      0.0
    end

    def total_after_discount
      subtotal - discount
    end

    def delivery_charge
      @delivery_rule.call(total_after_discount)
    end

    def enforce_valid_quantity(quantity)
      raise ArgumentError, 'Quantity must be a positive integer' unless valid_quantity?(quantity)
    end

    def valid_quantity?(quantity)
      quantity.is_a?(Integer) && !quantity.negative?
    end
  end
end
