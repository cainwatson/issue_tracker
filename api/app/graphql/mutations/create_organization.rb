module Mutations
  class CreateOrganization < Mutations::BaseMutation
    description 'Create a new organization.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :name, String, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [String], null: true

    def resolve(user_creator:, name:)
      organization = Organizations::Organization.create(
        name: name,
        user_creator: user_creator
      )

      if organization.invalid?
        { errors: organization.errors.full_messages }
      else
        { organization: organization }
      end
    end
  end
end
