Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "match_pages#index"
    devise_for :users, controllers: {registrations: "user/registrations"}
    get "/match", to: "match_pages#index"
    get "/next", to: "match_pages#next"
    resources :users
    resources :relationships, only: %i(create destroy)
    resources :match_pages, only: %i(create)
    namespace :admin do
      root to: "admin_pages#index"
      get "/export", to: "admin_pages#export"
      resources :admin_pages do
        patch :upgrade, on: :member
        collection { post :import }
      end
    end
    resources :messages, only: %i(show create index)
    mount ActionCable.server, at: "/cable"
  end

  namespace :api do
    namespace :v1 do
      resources :users
      resources :admin_pages do
        patch :upgrade, on: :member
      end
    end
  end
end
