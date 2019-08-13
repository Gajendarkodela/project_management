Rails.application.routes.draw do
  resources :developers
  devise_for :users
  resources :todos do
		member do
			post 'update_status'
		end
	end

  resources :welcome do
	get 'index', on: :collection
  end
  root 'welcome#index'
  resources :projects do
	member do
	  get 'graph'
	  post 'assign_devs'
	end
  end
  root 'projects#index'  
end