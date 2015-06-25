class Spree::LineItemsController < Spree::StoreController
  prepend_before_filter :load_object
  before_filter { unauthorized unless @user }
  before_filter :find_line_item, only: [:edit, :update]
  include Spree::Core::ControllerHelpers
  
  def edit
  end
  
  def update
    @line_item = @line_item.update_attributes(line_item_params)
    redirect_to main_app.inventory_path
  end

  private
  
  def find_line_item
    @order = spree_current_user.orders.find(params[:order_id])
    @line_item = @order.line_items.find(params[:id])
  end
  
  def line_item_params
    params.require(:line_item).permit(:image, :item_description)
  end

  def load_object
    @user ||= spree_current_user
  end

  def accurate_title
    'Inventory'
  end
end
