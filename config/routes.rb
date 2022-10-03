Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "devise/sessions#new"
    get "/match", to: "match_pages#index"
    get "/admin", to: "admin_pages#index"
    get "/next", to: "match_pages#next"
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
