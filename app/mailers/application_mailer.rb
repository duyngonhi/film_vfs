class ApplicationMailer < ActionMailer::Base
  default from: Setting.email.from_email
  layout "mailer"
end
