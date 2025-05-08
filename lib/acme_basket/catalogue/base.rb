# frozen_string_literal: true

module AcmeBasket
  module Catalogue
    # This is the base class for catalogues.
    # It implements all methods shared across different catalogues.
    class Base
      def initialize(products)
        @products = products.to_h { |p| [p[:code], AcmeBasket::Product.new(**p)] }
      end

      def find(code)
        @products[code]
      end
    end
  end
end
