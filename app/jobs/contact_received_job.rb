class ContactReceivedJob < ApplicationJob
  queue_as :default

  def perform(contact)
    FrontMailer.contact_received(contact).deliver_later
    Manager.where(mail_accept: true).each do |manager|
      AdminMailer.contact_received(contact, manager.email).deliver_later
    end
  end
end
