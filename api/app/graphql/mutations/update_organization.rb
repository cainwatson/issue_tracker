module Mutations
  class UpdateOrganization < Mutations::BaseMutation
    description 'Update an organization.'

    argument :organization_id, ID, required: true, loads: Types::OrganizationType
    argument :name, String, required: false

    field :organization, Types::OrganizationType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      organization = args[:organization]
      update_args = args.slice(:name).compact

      if organization.update(update_args)
        { organization: organization }
      else
        { errors: organization.errors.full_messages }
      end
    end
  end
end
