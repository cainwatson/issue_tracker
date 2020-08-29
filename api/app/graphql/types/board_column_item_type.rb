module Types
  class BoardColumnItemType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :user_creator, Types::UserType, null: false
    field :column, Types::BoardColumnType, null: false
    field :issue, Types::IssueType, null: true
  end
end
