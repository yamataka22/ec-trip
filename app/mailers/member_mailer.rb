class MemberMailer < ApplicationMailer
  default :template_path => "mailers/#{self.name.underscore}"

  def purchase_complete(purchase)
    @purchase = purchase
    mail to: purchase.member.email, subject: '【EC-TRIP】ご注文ありがとうございます'
  end
end
