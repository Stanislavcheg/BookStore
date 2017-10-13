class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :remember_location

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      begin
        Order.find(session[:order_id])
      rescue
        session[:order_id] = nil
        Order.new
      end
    end
  end

  def remember_location
    session[:prev_location] = request.referrer
  end
end
