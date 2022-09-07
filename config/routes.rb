Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "landing_pages#home"
  end
end
