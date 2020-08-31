module Mutations
  class CreateOrganization < Mutations::BaseMutation
    argument :name, String, required: true
    argument :user_creator_id, ID, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [String], null: false

    def resolve(name:, user_creator_id:)
      {
        organization: Organizations::Organization.create(name: name, user_creator_id: user_creator_id),
        errors: []
      }
    end
  end
end
