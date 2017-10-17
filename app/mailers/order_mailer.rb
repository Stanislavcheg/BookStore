class OrderMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def order_created(order, user)
    @user = user
    @order = order
    mail(to: @user.email, subject: t('order_mailer.subject'))
  end
end
