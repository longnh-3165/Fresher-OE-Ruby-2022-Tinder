Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root to: "devise/sessions#new"
    get "/match", to: "match_pages#index"
    get "/next", to: "match_pages#next"
    get "/export", to: "admin_pages#export"
    resources :users
    resources :relationships, only: %i(create destroy)
    resources :match_pages, only: %i(create)
    namespace :admin do
      root to: "admin_pages#index"
      resources :admin_pages do
        patch :upgrade, on: :member
        collection { post :import }
      end
    end
    resources :messages, only: %i(show create index)
    mount ActionCable.server, at: "/cable"
  end
end
