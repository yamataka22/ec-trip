class CreditCard < ApplicationRecord
  belongs_to :member

  def card_info
    "#{self.brand} #{self.last4} #{self.exp_month}/#{self.exp_year} #{self.holder}"
  end
end
