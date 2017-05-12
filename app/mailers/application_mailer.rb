class ApplicationMailer < ActionMailer::Base
  default from: Settings.email.from_email
  layout "mailer"
end
