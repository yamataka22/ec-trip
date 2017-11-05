module FrontHelper

  def fa_card(brand)
    case brand
      when 'Visa'
        'fa-cc-visa'
      when 'MasterCard'
        'fa-cc-mastercard'
      when 'American Express'
        'fa-cc-amex'
      else
        'fa-credit-card'
    end
  end

  def select_years(upto = 10)
    Date.current.year..(Date.current.year + upto)
  end

  def select_months
    1..12
  end

  def ceil_cart_quantity(cart)
    default_max = 5
    if cart.item.stock_quantity < default_max
      cart.item.stock_quantity
    elsif cart.quantity > default_max
      cart.quantity
    else
      default_max
    end
  end
end