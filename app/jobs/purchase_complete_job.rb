class PurchaseCompleteJob < ApplicationJob
  queue_as :default

  def perform(purchase)
    FrontMailer.purchase_complete(purchase).deliver_later
    Manager.where(mail_accept: true).each do |manager|
      AdminMailer.new_ordered(purchase, manager.email).deliver_later
    end
  end
end
