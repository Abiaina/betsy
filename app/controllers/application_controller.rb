class ApplicationController < ActionController::Base

  before_action :find_order
  before_action :current_user
  
  private
  
  def find_order
    if session[:order_id]
      @order = Order.find_by(id: session[:order_id])
    end
    
    if @order.nil?
      @order = Order.create(status: "pending")
      session[:order_id] = @order.id
      session[:recently_viewed] = Array.new
    end

    current_user
  end
  
  def current_user
    if session[:user_id]
      @current_user = Merchant.find_by(id: session[:user_id])
    end
    
    if @current_user.nil?
      session[:user_id] = nil
    end
  end

  def add_to_recently_viewed(product)
    @recent = session[:recently_viewed]
    @recent.insert(0, product)
    
    if @recent.count > 11
      @recent.last.delete
    end

    session[:recently_viewed] = @recent
  end
end
