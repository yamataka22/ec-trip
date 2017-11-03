class Admin::TopController < Admin::AdminBase
  def index
    @recent_purchase_summaries = Purchase.select('created_at, COUNT(id) AS count, SUM(item_amount + delivery_fee + tax) AS amount').where('created_at >= ?', Date.current - 4.days).group(:created_at).order(created_at: :desc)
    @undelivered_counts = Purchase.where(delivered: false).count
    @selling_item_counts = Item.selling.count
    @member_counts = Member.where(leave_at: nil).where.not(confirmed_at: nil).count
    @current_month_purchase_summary = Purchase.select('SUM(item_amount + delivery_fee + tax) AS amount').where('created_at >= ?', Date.current.beginning_of_month).first.amount
    @limit_stock_items = Item.selling.where('`stock_quantity` <= 5').order(:stock_quantity).limit(5)
    @unread_contacts = Contact.where(read: false).order(:created_at).limit(5)
    render 'admin/top'
  end
end
