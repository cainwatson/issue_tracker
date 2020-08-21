module Types
  class ProfileType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :first_name, String, null: false
    field :last_name, String, null: true
    field :photo_url, String, null: true

    field :user, Types::UserType, null: false
  end
end
