SourceLovers::Application.routes.draw do
  resources :projects, :only => [:index, :show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Webhooks
  post 'hooks/github'
end
