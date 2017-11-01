class Admin::PurchaseSearchForm
  include ActiveModel::Model

  attr_accessor :delivered, :email, :purchased_at_from, :purchased_at_to, :remarks

  def search(page)
    purchases = Purchase.includes(:member, details: [:item])
    purchases = purchases.where(delivered: false) if delivered.blank?
    purchases = purchases.where(member: [email: email]) if email.present?
    purchases = purchases.where('`purchases`.`created_at` >= ?', purchased_at_from) if purchased_at_from.present?
    purchases = purchases.where('`purchases`.`created_at` <= ?', purchased_at_to) if purchased_at_to.present?
    purchases = purchases.where('`purchases`.`remarks` LIKE ?', "%#{remarks}%") if remarks.present?
    purchases.page(page).per(50).order(id: :desc)
  end

end