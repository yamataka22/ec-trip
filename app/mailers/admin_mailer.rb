class AdminMailer < ApplicationMailer
  default :template_path => "mailers/#{self.name.underscore}"
  layout 'admin_mailer'

  def new_ordered(purchase, mail_to)
    @purchase = purchase
    mail to: mail_to, subject: '【EC-TRIP】新規注文のお知らせ'
  end

  def contact_received(contact, mail_to)
    @contact = contact
    mail to: mail_to, subject: '【EC-TRIP】お問い合わせのお知らせ'
  end
end
