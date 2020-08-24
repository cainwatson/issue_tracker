Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/graphql', to: 'graphql#execute'
  mount GraphQL::Playground::Engine, at: '/graphql-playground', graphql_path: '/graphql' if Rails.env.development?
end
