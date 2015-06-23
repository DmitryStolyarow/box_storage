class Spree::InventoryController < Spree::StoreController
  # skip_before_filter :set_current_order
  prepend_before_filter :load_object
  before_filter { unauthorized unless @user }
  # prepend_before_filter :authorize_actions
  # before_action :check_authorization

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

  # def user_params
  #   params.require(:user).permit(Spree::PermittedAttributes.user_attributes)
  # end

  def load_object
    @user ||= spree_current_user
    # authorize! params[:action].to_sym, @user
  end

  # def authorize_actions
  #   authorize! params[:action].to_sym, Spree::User.new
  # end

  def accurate_title
    'Inventory'
  end
end
