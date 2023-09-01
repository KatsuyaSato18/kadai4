Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :admin do
    resources :customers, only:[:index,:show,:edit,:update]
    resources :items, only:[:new, :index,:show,:edit,:update,:create]
    resources :orders, only:[:show]
    root to: 'homes#top'
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'orders/thanks', to: 'orders#thanks'
    resources :orders, only: [:index, :show, :new, :create]
    #resources :customers, only: [:show, :edit, :withdrawal]
    # routes.rb
    post 'orders/check', to: 'orders#check'
    get 'customers/my_page', to: 'customers#show' ,as: :my_page
    get '/customers/information/edit', to: 'customers#edit', as: :customers_edit
    patch '/customers/information', to: 'customers#update'
    patch '/customers/quit', to: 'customers#quit'
    get 'customers/withdrawal'
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
