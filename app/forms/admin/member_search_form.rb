class Admin::MemberSearchForm
  include ActiveModel::Model

  attr_accessor :email, :account_name, :created_at_from, :created_at_to, :leaved

  def search(page)
    members = Member.where.not(confirmed_at: nil)
    members = members.where('`members`.`email` like ?', "%#{email}%") if email.present?
    members = members.where('`members`.`account_name` like ?', "%#{account_name}%") if account_name.present?
    members = members.where('`members`.`created_at` >= ?', created_at_from) if created_at_from.present?
    members = members.where('`members`.`created_at` <= ?', created_at_to) if created_at_to.present?
    members = members.where(leave_at: nil) if leaved.blank? || leaved == '0'
    members.page(page).per(50).order(id: :desc)
  end

end