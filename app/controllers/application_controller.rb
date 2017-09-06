class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :categories, :current_order
  before_action :remember_location

  def categories
    Category.all
  end

  def current_order
    unless session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def remember_location
    session[:prev_location] = request.referrer
  end
end
