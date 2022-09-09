Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "landing_pages#home"
    post "/login", to: "sessions#create"
    resources :users, only: %i(show)
  end
end
