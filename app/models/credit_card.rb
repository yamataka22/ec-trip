class CreditCard < ApplicationRecord
  belongs_to :member

  accepts_nested_attributes_for :member

  def card_info
    "#{self.brand} #{self.last4} #{self.exp_month}/#{self.exp_year} #{self.name}"
  end

  def token_save(stripe_token)
    stripe_card = StripeOperate.card_create(self.member.stripe_customer_id, stripe_token)
    unless stripe_card
      return false
    end
    self.stripe_card_id = stripe_card.id
    self.brand = stripe_card.brand
    self.last4 = stripe_card.last4
    self.exp_month = stripe_card.exp_month
    self.exp_year = stripe_card.exp_year
    self.name = stripe_card.name

    if save
      if self.member.main_credit_card_id.blank?
        self.member.main_credit_card_id = self.id
        self.member.save!
      end
      true
    else
      false
    end
  end

  def destroy
    if super
      # メインカードIDもクリアする
      self.member.main_credit_card_id = nil if self.member.main_credit_card_id == self.id
    else
      false
    end
  end
end
