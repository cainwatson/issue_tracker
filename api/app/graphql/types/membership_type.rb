module Types
  class MembershipType < Types::BaseObject
    field :id, ID, null: false
    field :user_from, Types::UserType, null: false
    field :user_to, Types::UserType, null: false
    field :organization, Types::OrganizationType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
