# Acme Basket

A lightweight Ruby gem that models a shopping basket with support for:

- An expandable product catalogue (including Red, Green, and Blue widgets)
- Special offers (like "buy one get second one half price")
- Delivery pricing rules based on basket total

## Installation

Clone this repository, navigate to the root folder and install dependencies:

```bash
bundle install
```

## Usage

Start the console:

```bash
./bin/console
```

Example usage:

```ruby
basket = AcmeBasket::Basket.new(offers: [AcmeBasket::Offer::BuyRedWidgetGetSecondHalf.new])

basket.add("R01", 2)
puts basket.total  # => 54.37
basket.remove("R01")
puts basket.total  # => 37.9
basket.add("G01")
puts basket.total  # => 60.85
basket.clear
puts basket.total  # => 0.0
```

You can also pass a custom catalogue:

```ruby
custom_products = [
  { code: 'X01', name: 'Xtreme Widget', price: 99.99 }
]
catalogue = AcmeBasket::Catalogue.new(custom_products)
basket = AcmeBasket::Basket.new(catalogue: catalogue)
```

At any time, you can view the items in an instantiated basket:

```ruby
basket.items
```

## Unit Tests

Unit tests have been included, with RSpec. To run tests:

```bash
bundle exec rspec
```

## Linting

This project follows Rubocop specs for Ruby projects. To run lint:

```bash
bundle exec rubocop
```

## Test Totals

| Products                      | Expected Total |
|-------------------------------|----------------|
| `B01, G01`                    | `$37.85`       |
| `R01, R01`                    | `$54.37`       |
| `R01, G01`                    | `$60.85`       |
| `B01, B01, R01, R01, R01`     | `$98.27`       |


## Notes

- This project is designed to be included as a gem in your main project. It is lightweight and requires no database or http calls.
- Delivery pricing is currently fixed inside the widget delivery rules class. The idea is that if that is to change, we can easily define another subclass and let the caller inject the appropriate delivery rule on instantiating the basket class.
- `WidgetCatalogue` is a concrete subclass of the Base Catalogue with built-in frozen data. As your shop grows, you can add more catalogues. See `usage` section above to see how to inject catalogues when instantiating your basket.
- `Basket` supports dependency injection for catalogue, delivery rules, and offers.
- Multiple offers can be combined, but a particular offer cannot be applied more than once, no matter how many times it is passed in to `Basket.new`.
- This gem uses Pry for local experimentation via `bin/console`.

## Potential improvements
- Allow shopping across multiple catalogues.

---

MIT License
