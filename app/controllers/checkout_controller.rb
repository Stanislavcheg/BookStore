class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :authenticate_user!, :check_preconditions

  def show
    case step
    when :address
      @addresses_form = AddressFormBuilder.build_from_model(current_user, current_order)
    when :delivery
      @delivery_form = DeliveryFormBuilder.build_from_model(current_order)
    when :payment
      @payment_form = PaymentFormBuilder.build_from_model(current_order)
    when :complete
      if session[:prev_step_done]
        link_current_order_to_user
        @order = current_user.last_order
        OrderMailer.order_created(@order, current_user).deliver_later
        session[:order_id] = nil
        session[:prev_step_done] = nil
      end
    end
    render_wizard
  end

  def update
    form =  case step
            when :address
              @addresses_form = AddressesForm.from_params(params)
            when :delivery
              @delivery_form = DeliveryForm.from_params(params[:delivery])
            when :payment
              @payment_form = PaymentForm.from_params(params[:credit_card])
            end
    form.with_context(order: current_order)
    mark_step_as_done(form.valid?)
    render_wizard form
  end

  private

  def check_preconditions
    redirect_to cart_path if current_order.positions.count.zero?
    return if step == :address
    jump_to(previous_step) unless session[:prev_step_done]
  end

  def link_current_order_to_user
    current_order.update_attributes(user_id: current_user.id) if current_order.user_id.nil?
  end

  def mark_step_as_done(is_done)
    session[:prev_step_done] = is_done
  end
end
