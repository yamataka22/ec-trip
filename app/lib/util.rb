module Util

  def calc_tax_included(sub_total)
    (BigDecimal(sub_total.to_s) * BigDecimal(Tax.now.to_s)).ceil
  end

  def calc_tax(sub_total)
    self.calc_tax_included(sub_total) - sub_total
  end

end