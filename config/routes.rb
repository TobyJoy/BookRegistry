Rails.application.routes.draw do
  root :to => "home#index"
  
  devise_for :users
  resources :books do
    member do
      patch 'publish_book'
    end
    collection do
      get 'sort_books'
    end
  end
end
