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
end