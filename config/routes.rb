Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "landing_pages#home"
    post "/login", to: "sessions#create"
    get "/match", to: "match_pages#match"
    get "/admin", to: "admin_pages#index"
    resources :users, only: %i(show)
    resources :relationships, only: %i(create)
    resources :match_pages, only: %i(create)
  end
end
