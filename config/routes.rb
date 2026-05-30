Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  root "home#index"

  resources :characters, only: [:new, :create, :show] do
    member do
      post :select
      patch :spend_points
      patch :update_avatar
    end
    resources :inventories, only: [:index] do
      member do
        patch :toggle_equip
      end
    end
  end

  resources :quests, only: [:index, :show] do
    member do
      post :claim_reward
    end
    resources :quest_progresses, only: [:create] do
      member do
        post :answer_riddle
        post :skip_to_reward
      end
    end
  end

  resources :combat_sessions, only: [:create, :show] do
    member do
      post :attack
    end
  end

  resources :auction_listings, only: [:index, :new, :create, :destroy] do
    member do
      post :buy
    end
  end

  resources :messages, only: [:create]

  namespace :admin do
    root "dashboard#index"
    resources :quests do
      resources :steps do
        resources :npcs, only: [:new, :create, :edit, :update, :destroy]
        resources :riddles, only: [:new, :create, :edit, :update, :destroy] do
          resources :answers, only: [:create, :update, :destroy]
        end
      end
    end
    resources :items
    resources :characters, only: [:index, :show]
  end
end
