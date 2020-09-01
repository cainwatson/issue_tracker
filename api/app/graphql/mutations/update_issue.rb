module Mutations
  class UpdateIssue < Mutations::BaseMutation
    argument :summary, String, required: false
    argument :description, String, required: false
    argument :issue_id, ID, required: true

    field :issue, Types::IssueType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      issue = IssueTrackerSchema.object_from_id(args[:issue_id])
      update_args = args.slice(:summary, :description).compact

      if issue.update(update_args)
        { issue: issue, errors: [] }
      else
        { errors: issue.errors.full_messages }
      end
    end
  end
end
