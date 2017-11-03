class MailInterceptor

  def self.delivering_email(message)

    if BounceMail.exists?(email: message.to) ||
      Member.where(email: message.to).where.not(leave_at: nil).exists?
      # BounceMailリストと退会者へはメールしない
      message.perform_deliveries = false
    end

    unless Rails.env.production?
      # production以外はdeveloper_mailsに登録されているアドレスにのみ送信する
      unless DeveloperMail.exists?(email: message.to)
        message.perform_deliveries = false
      end

      # 件名にテストを付与する
      message.subject.insert(0, '[テストメール]')
    end

  end

end