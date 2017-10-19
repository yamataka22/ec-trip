class Cart < ApplicationRecord
  belongs_to :member
  belongs_to :item

  def self.add_item(member, item_id)
    cart = Cart.find_or_initialize_by(member: member, item_id: item_id)
    cart.quantity += 1
    cart.save! && cart
  end
end
