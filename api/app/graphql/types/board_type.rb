module Types
  class BoardType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :name, String, null: false

    field :user_creator, Types::UserType, null: false
    field :project, Types::ProjectType, null: false
  end
end
