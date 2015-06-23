Rails.application.routes.draw do
  mount Spree::Core::Engine, :at => '/'
  get 'inventory' => 'spree/inventory#index', as: 'inventory'
end
