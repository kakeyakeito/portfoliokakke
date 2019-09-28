Rails.application.routes.draw do
  devise_for :admins, controllers: {
 sessions:      'admins/sessions',
 passwords:     'admins/passwords',
 registrations: 'admins/registrations'
 }
 devise_for :users, controllers: {
 sessions:      'users/sessions',
 passwords:     'users/passwords',
 registrations: 'users/registrations'
 }

  root 'tops#top'
  get 'tops/all_top' => 'tops#all_top'
  get 'tops/about' => 'tops#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :users, only: [:show,:edit,:update,:destroy] do
  	member do
  		get :following, :followers, :mypage, :favorite_index, :blockeds, :blocking, :block_index
  	end
  end
  	resources :relationships, only: [:create,:destroy]
    resources :block_relationships, only: [:create,:destroy]
  	get 'tops/follow_top' => 'tops#follow_top'
  	get 'searches/search' => 'searches#search'
  	resources :posts, only: [:show,:edit,:new,:update,:create,:destroy] do
      member do
        get :tag_post_index, :favorite_user_index
      end
  		resources :favorites, only: [:create,:destroy]
  		resources :comments, only: [:create,:new,:destroy] do
        member do
          get :reply
          post :reply_create
        end
      end
  	end
  	resources :tags, only: [:create,:destroy,:edit]
  	resources :messages, only: [:create,:new]
  	resources :rooms, only: [:create,:index,:show]




  namespace :admins do
  	get 'tops' => 'tops#top'
  	#adminのTopページ↑
  	get 'searches/search' => 'searches#search'

  	resources :tags, only: [:index,:destroy]
  	resources :users, only: [:show,:index,:edit,:update,:destroy] do
  		member do
  			get :following, :followers ,:favorite_index
  		end
    end
	 resources :relationships, only: [:create,:destroy]
	 resources :posts, only: [:index,:show,:edit,:update,:destroy] do
      member do
        get :tag_post_index, :favorite_user_index
      end
	  	resources :favorites, only: [:show,:index]
	  	resources :comments, only: [:destroy]
	  end
  end

end