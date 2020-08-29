module Types
  class ProjectType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :name, String, null: false
    field :photo_url, String, null: true
    field :is_private, Boolean, null: false
    field :owner_type, Types::ProjectOwnerCategory, null: false

    field :owner, Types::ProjectOwner, null: false
    field :user_creator, Types::UserType, null: false
    field :issues, [Types::IssueType], null: false
    field :boards, [Types::BoardType], null: false
  end
end
