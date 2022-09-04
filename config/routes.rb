Rails.application.routes.draw do
  post '/', to: 'acts#create'
  root 'acts#new'
end
