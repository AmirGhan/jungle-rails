class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: 'Your Order Confirmation for your order ID: #{@order.id}')
  end
end
