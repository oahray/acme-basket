# frozen_string_literal: true

module AcmeBasket
  module Offer
    # Base class for all offer types.
    class Base
      # This constant should be overridden in subclasses to provide marketing copy.
      MARKETING_COPY = ''

      def apply(items)
        raise NotImplementedError, 'Subclasses must implement `apply`'
      end

      def marketing_copy
        self.class::MARKETING_COPY
      end
    end
  end
end
