# frozen_string_literal: true

module AcmeBasket
  module Catalogue
    # Concrete subclass for widget catalogue
    class WidgetCatalogue < Base
      PRODUCTS = [
        { code: 'R01', name: 'Red Widget', price: 32.95 },
        { code: 'G01', name: 'Green Widget', price: 24.95 },
        { code: 'B01', name: 'Blue Widget', price: 7.95 }
      ].freeze

      def initialize
        super(PRODUCTS)
      end
    end
  end
end
