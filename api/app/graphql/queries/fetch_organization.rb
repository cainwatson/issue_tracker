module Queries
  class FetchOrganization < Queries::BaseQuery
    type Types::OrganizationType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      Organizations::Organization.find(id)
    rescue ActiveRecord::RecordNotFound => _error
      nil
    end
  end
end