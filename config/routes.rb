Rails.application.routes.draw do
  mount Spree::Core::Engine, :at => '/'
  get 'inventory' => 'spree/inventory#index', as: 'inventory'
  scope '', module: :spree do
    resources :orders, only: :show do
      resources :returns, only: [:new, :create]
      resources :line_items, only: [:edit, :update]
    end
  end
end
