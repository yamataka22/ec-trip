module Util

  def self.calc_tax_included(amount)
    (BigDecimal(amount.to_s) * BigDecimal(Tax.now.to_s)).ceil
  end

  def self.calc_tax(amount)
    self.calc_tax_included(amount) - amount
  end

  def self.random_string(i)
    [*1..9, *'a'..'z'].sample(i).join
  end

end