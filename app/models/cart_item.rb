class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  TAX_RATE = 0.1
  def sum_price
    tax_included_price(item.price) * amount
  end

  private

  def tax_included_price(price)
    (price * (1 + TAX_RATE)).round
  end

end
