# Preview all emails at http://localhost:3000/rails/mailers/front_mailer
class FrontMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/front_mailer/purchase_complete
  def purchase_complete
    FrontMailer.purchase_complete
  end

end
