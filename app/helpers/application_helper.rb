module ApplicationHelper

  TAX_RATE = 0.08

  def tax_included_price(price)
    (price * (1 + TAX_RATE)).round
  end

end
