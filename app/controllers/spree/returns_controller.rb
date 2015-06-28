class Spree::ReturnsController < Spree::StoreController
  prepend_before_filter :load_object
  before_filter { unauthorized unless @user }
  before_filter :find_line_item, only: [:new, :create]
  include Spree::Core::ControllerHelpers
  
  def new
    redirect_to main_app.inventory_path unless @line_item
  end
  
  def create
    if params[:return_at].in?(%w(7am-9am 3pm-6pm 6pm-9pm))
      ItemReturnMailer.email(spree_current_user, @line_item, params[:return_at]).deliver
      redirect_to main_app.inventory_path
    else
      flash[:error] = 'You need to specify return time'
      render :new
    end
    
  end

  private
  
  def find_line_item
    @order = spree_current_user.orders.find(params[:order_id])
    @line_item = @order.line_items.find_by_id(params[:line_item_id])
  end

  def load_object
    @user ||= spree_current_user
  end

  def accurate_title
    'Inventory'
  end
end
