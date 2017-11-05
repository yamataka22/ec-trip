class StripeOperate

  def self.charge_create(stripe_customer_id, stripe_card_id, amount)
    begin
      Stripe::Charge.create(
          amount: amount,
          currency: 'jpy',
          customer: stripe_customer_id,
          source: stripe_card_id
      )
    rescue => e
      Rails.logger.info e.message
      nil
    end
  end

  def self.token_charge_create(token, cart_session_id, amount)
    begin
      Stripe::Charge.create(
          amount: amount,
          currency: 'jpy',
          source: token,
          description: "cart_session_id: #{cart_session_id}"
      )
    rescue => e
      Rails.logger.info e.message
      nil
    end
  end

  def self.card_create(stripe_customer_id, stripe_token)
    begin
      stripe_customer = Stripe::Customer.retrieve(stripe_customer_id)
      stripe_customer.sources.create({source: stripe_token})
    rescue => e
      Rails.logger.info e.message
      nil
    end
  end


end