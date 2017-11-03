class MemberMailer < ApplicationMailer
  default :template_path => "mailers/#{self.name.underscore}"
  layout 'front_mailer'

  def purchase_complete(purchase)
    @purchase = purchase
    mail to: purchase.member.email, subject: '【EC-TRIP】ご注文ありがとうございます'
  end

  def contact_received(contact)
    @contact = contact
    mail to: contact.email, subject: '【EC-TRIP】お問い合わせを受付ました'
  end
end
