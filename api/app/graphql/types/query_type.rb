module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    add_field(GraphQL::Types::Relay::NodeField)
    add_field(GraphQL::Types::Relay::NodesField)

    field :users, resolver: Queries::FetchUsers

    field :organization, resolver: Queries::FetchOrganization
  end
end
