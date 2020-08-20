module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :photo_url, String, null: true
    field :is_private, Boolean, null: false
    field :user_creator_id, Integer, null: false
    field :owner_type, Types::ProjectOwnerType, null: false
    field :owner_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
