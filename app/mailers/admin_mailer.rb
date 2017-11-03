class AdminMailer < ApplicationMailer
  default :template_path => "mailers/#{self.name.underscore}"

  def new_ordered(purchase, mail_to)
    @purchase = purchase
    mail to: mail_to, subject: '【EC-TRIP】新規注文を承りました'
  end
end
