module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :profile, Types::ProfileType, null: false
    field :projects, [Types::ProjectType], null: false
    field :memberships, [Types::MembershipType], null: false
  end
end
