Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "landing_pages#home"
    post "/login", to: "sessions#create"
    get "/match", to: "match_pages#match"
    get "/admin", to: "admin_pages#index"
    get "/signup", to: "users#new"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :relationships, only: %i(create destroy)
    resources :match_pages, only: %i(create)
    resources :admin_pages do
      patch :upgrade, on: :member
    end
    resources :messages, only: %i(show create index)
    mount ActionCable.server, at: "/cable"
  end
end
