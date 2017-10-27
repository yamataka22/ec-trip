class Cart < ApplicationRecord
  belongs_to :member
  belongs_to :item

  validates :quantity, numericality: { only_integer: true, greater_than: 1 }, presence: true

  def self.add_item(member, item_id, quantity = 1)
    cart = Cart.find_or_initialize_by(member: member, item_id: item_id)
    cart.quantity += quantity
    if cart.item_error.present?
      return false
    else
      cart.save! && cart
    end
  end

  def item_error
    return :item_end if self.item.end_of_sell?
    return :unpublished if self.item.unpublished?
    return :zero if self.item.stock_quantity == 0
    return :minus if self.quantity > self.item.stock_quantity
    nil
  end

end
