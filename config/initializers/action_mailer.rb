require_relative '../../app/lib/mail_interceptor'
ActionMailer::Base.register_interceptor(MailInterceptor)
