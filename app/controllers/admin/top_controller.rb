class Admin::TopController < ApplicationController
  layout 'admin'
  def index
    redirect_to new_manager_session_path and return unless manager_signed_in?

    @recent_purchase_summaries = Purchase.select('purchased_date, COUNT(id) AS count, SUM(item_amount + delivery_fee + tax) AS amount').where('purchased_date >= ?', Date.current - 6.days).group(:purchased_date).order(purchased_date: :desc)
    @undelivered_counts = Purchase.where(delivered: false).count
    @selling_item_counts = Item.where(status: :selling).count
    @member_counts = Member.where(leave_at: nil).where.not(confirmed_at: nil).count
    @current_month_purchase_summary = Purchase.select('SUM(item_amount + delivery_fee + tax) AS amount').where('purchased_date >= ?', Date.current.beginning_of_month).first.amount
    @limit_stock_items = Item.where(status: :selling).where('`stock_quantity` <= 5').order(:stock_quantity).limit(5)
    @unread_contacts = Contact.where(read: false).order(created_at: :desc).limit(5)
    render 'admin/top'
  end
end
