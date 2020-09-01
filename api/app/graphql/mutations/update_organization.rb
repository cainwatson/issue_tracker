module Mutations
  class UpdateOrganization < Mutations::BaseMutation
    argument :organization_id, ID, required: true
    argument :name, String, required: false

    field :organization, Types::OrganizationType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      organization = IssueTrackerSchema.object_from_id(args[:organization_id])
      update_args = args.slice(:name).compact()

      if organization.update(update_args)
        { organization: organization, errors: [] }
      else
        { errors: organization.errors.full_messages }
      end
    end
  end
end
