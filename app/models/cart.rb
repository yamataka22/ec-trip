class Cart < ApplicationRecord
  belongs_to :member
  belongs_to :item

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true

  def self.add_item(item_id, member, cart_session_id)
    if member.present?
      cart = Cart.find_or_initialize_by(member: member, item_id: item_id)
    else
      cart = Cart.find_or_initialize_by(session_id: cart_session_id, item_id: item_id)
    end
    cart.quantity += 1
    if cart.item_error.present?
      return false
    else
      cart.save! && cart
    end
  end

  def update_quantity(quantity)
    self.quantity = quantity
    if self.item_error.present?
      false
    else
      self.save!
    end
  end

  def item_error
    return :item_end if self.item.end_of_sell?
    return :unpublished if self.item.unpublished?
    return :zero if self.item.stock_quantity == 0
    return :minus if self.quantity > self.item.stock_quantity
    nil
  end

  def self.current_quantity(member, cart_session_id)
    Cart.search(member, cart_session_id)&.sum(:quantity) || 0
  end

  def self.current_amount(member, cart_session_id)
    amount = 0
    Cart.search(member, cart_session_id)&.each do |cart|
      amount = amount + cart.item.price * cart.quantity
    end
    amount
  end

  def self.search(member, cart_session_id)
    if member.present?
      Cart.where(member: member)
    elsif cart_session_id.present?
      Cart.where(member: nil, session_id: cart_session_id)
    else
      nil
    end
  end

  def self.merge_session(member, cart_session_id)
    return if cart_session_id.blank?
    Cart.where(member: nil, session_id: cart_session_id).each do |session_cart|
      member_cart = Cart.find_or_initialize_by(member: member, item: session_cart.item)
      member_cart.quantity += session_cart.quantity
      member_cart.save!
      session_cart.destroy!
    end
  end

end
