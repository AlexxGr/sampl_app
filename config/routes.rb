
Rails.application.routes.draw do
#get 'users/new'
resources :users
# Определяем маршурты для ресурса (контроллера) Sessions с помощью метода resource 
# без действия редактирование (:edit) c помощью опции only:
resource :sessions, only: [:new, :create, :destroy]
# исправленная версия 
# по адресу http://rails-3-2.railstutorial.org/book/filling_in_the_layout#sec-rails_routes
# Взято оттуда что  вверху, но найдо в инете что в конце надо
# ,  :via => :get 
root to: 'static_pages#home'
match '/signup',  to: 'users#new',             via: :get
# =============   добавим для ресурса sessions ================
match '/signin',   to: 'sessions#new',         via: [:get]
match '/signout',  to: 'sessions#destroy',     via: :delete
# Разные способы записи 
#     via: :get
#     via: [:get] - тут может через запятную перчсилять :post, :get
#     :via => :get - аналогично верхнему
# =============================================================
match '/help',    to: 'static_pages#help',     :via => :get 
match '/about',   to: 'static_pages#about',    :via => :get 
match '/contact', to: 'static_pages#contact',  :via => :get


# это было чуть позже, но видимо все-ткаи для рельсы 3.1
# root  to: 'static_pages#home'
 # match '/', to: 'static_pages#home', via: 'get'
# match '/help',    to: 'static_pages#help',    via: 'get'
# match '/about',   to: 'static_pages#about',   via: 'get'
# match '/contact', to: 'static_pages#contact', via: 'get'

# ==== это было раньше
#  get 'static_pages/home'
#  get 'static_pages/help'
#  get 'static_pages/about'
#  get 'static_pages/contact'

# вводим маршруты 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
