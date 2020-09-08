module Mutations
  class CreateOrganization < Mutations::BaseMutation
    description 'Create a new organization.'

    argument :name, String, required: true
    argument :user_creator_id, ID, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [String], null: true

    def resolve(name:, user_creator_id:)
      organization = Organizations::Organization.create(
        name: name,
        user_creator_id: IssueTrackerSchema.object_id_from_id(user_creator_id)
      )

      if organization.invalid?
        { errors: organization.errors.full_messages }
      else
        { organization: organization }
      end
    end
  end
end
