Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    resources :posts
    resources :images, only: [:index, :create, :destroy]
    resources :content_magnets
    resources :insert_content_magnets, only: [:index, :new, :create]
  end

  resources :subscribers, only: [:new, :create]
  resources :posts, only: [:index, :show], path: "blog"
  resources :tags, only: [:show]
  resources :content_magnets, only: [:show] do
    get 'subscribe', to: "content_magnets#new_subscriber"
    post 'subscribe', to: "content_magnets#subscribe"
  end

  get 'sitemap.xml', to: 'sitemaps#index', :format => "xml", :as => :sitemap
  
  root to: 'visitors#index'
end
