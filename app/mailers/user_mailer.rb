class UserMailer < ApplicationMailer
  def signup_confirmation
    @greeting = t('user_mailer.greeting')

    mail to: "to@example.org"
  end
end
