module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, resolver: Queries::FetchUsers
    field :user, resolver: Queries::FetchUser

    field :organization, resolver: Queries::FetchOrganization
  end
end
