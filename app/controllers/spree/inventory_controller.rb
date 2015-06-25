class Spree::InventoryController < Spree::StoreController
  prepend_before_filter :load_object
  before_filter { unauthorized unless @user }

  include Spree::Core::ControllerHelpers
  
  def index
    @line_items = @user.orders.complete.map(&:line_items).flatten
  end

  def show
    @orders = @user.orders.complete.order('completed_at desc')
  end
  
  def edit
  end
  
  def update
  end

  private

  def load_object
    @user ||= spree_current_user
  end

  def accurate_title
    'Inventory'
  end
end
