module Types
  class OrganizationType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :name, String, null: false
    field :photo_url, String, null: true

    field :user_creator, Types::UserType, null: false
    field :memberships, [Types::MembershipType], null: false
    field :projects, [Types::ProjectType], null: false
  end
end
