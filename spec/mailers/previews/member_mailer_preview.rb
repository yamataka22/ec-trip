# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/purchase_complete
  def purchase_complete
    MemberMailerMailer.purchase_complete
  end

end
