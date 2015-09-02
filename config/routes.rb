Rails.application.routes.draw do

  resources :questions

  resources :advertisements

  resources :topics do
  	resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root to: 'topics#index'

end