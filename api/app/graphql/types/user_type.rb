module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :profile, Types::ProfileType, null: false
    field :projects, [Types::ProjectType], null: false
    field :memberships, [Types::MembershipType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
