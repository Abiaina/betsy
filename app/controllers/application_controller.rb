class ApplicationController < ActionController::Base
  before_action :find_cart
  
  private
  
  def find_cart
    if session[:order_id]
      @cart = Order.find_by(id: session[:order_id])
    end
    
    if @cart.nil?
      @cart = Order.create(status: "pending")
      session[:order_id] = @cart.id
    end
  end

  def current_user
    if session[:user_id]
      @current_user = Merchant.find_by(id: session[:user_id])
    end

    if @current_user.nil?
      session[:user_id] = nil
    end
  end
end
