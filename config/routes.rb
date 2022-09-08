Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "landing_pages#home"
    get "/match", to: "match_page#match"
  end
end
