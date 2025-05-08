# frozen_string_literal: true

module AcmeBasket
  module DeliveryRule
    # This class defines the delivery rules for the widget catalogue
    class WidgetCharge
      def call(subtotal)
        if subtotal >= 90
          0.0
        elsif subtotal >= 50
          2.95
        else
          4.95
        end
      end
    end
  end
end
