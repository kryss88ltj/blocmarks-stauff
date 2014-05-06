Blocmarks::Application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  resources :sessions

  resources :users do
    resources :posts
  end
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :favorites, only: [:show, :create, :destroy]
    end
  end

  post :incoming, to: 'incoming#create'
    
  match "about" => 'welcome#about', via: :get


  root :to => 'welcome#index'

end
