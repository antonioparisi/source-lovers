SourceLovers::Application.routes.draw do
  post "hooks/github"
  post "hooks/stripe"
end
