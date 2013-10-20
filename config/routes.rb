SourceLovers::Application.routes.draw do
  resources :projects, :only => [:index] do
    match ':author', :to => 'projects#projects_author', :as => 'author', :on => :collection, :via => :get
    match ':author/:project_name', :to => 'projects#show', :as => 'show', :on => :collection, :via => :get
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Webhooks
  post 'hooks/github'
end
