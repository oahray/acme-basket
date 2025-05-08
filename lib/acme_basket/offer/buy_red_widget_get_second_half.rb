# frozen_string_literal: true

module AcmeBasket
  module Offer
    # This class implements the logic for giving half price for
    # each second red widget added to the shopping basket
    class BuyRedWidgetGetSecondHalf < Base
      RED_WIDGET_CODE = 'R01'
      MARKETING_COPY = 'Buy one red widget, get the second half price'

      def apply(items)
        matched = items.select { |p| p.code == RED_WIDGET_CODE }
        number_of_pairs = matched.count / 2
        price = AcmeBasket::Catalogue::WidgetCatalogue.new.find(RED_WIDGET_CODE).price

        number_of_pairs * price * 0.5
      end
    end
  end
end
