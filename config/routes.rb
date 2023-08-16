Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :admin do
    resources :customers, only:[:index,:show,:edit]
    resources :items, only:[:new, :index,:show,:edit]
    root to: 'homes#top'
    get 'orders/show'
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    #resources :customers, only: [:show, :edit, :withdrawal]
    get 'orders/new'
    get 'orders/thanks'
    get '/orders', to: 'orders#index', as: :orders_index
    get 'orders/show'
    get 'cart_items/index'
    get 'customers/my_page', to: 'customers#show' ,as: :my_page
    get '/customers/information/edit', to: 'customers#edit', as: :customers_edit
    patch '/customers/information', to: 'customers#update'
    patch '/customers/quit', to: 'customers#quit'
    get 'customers/withdrawal'
    #get '/items', to: 'items#index'
    #get 'items/show'
    get "/about" => "homes#about", as: "about"
  end
 # 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end
