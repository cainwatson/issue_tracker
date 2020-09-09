module Mutations
  class UpdateIssue < Mutations::BaseMutation
    description 'Update an issue.'

    argument :issue_id, ID, required: true, loads: Types::IssueType
    argument :summary, String, required: false
    argument :description, String, required: false

    field :issue, Types::IssueType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      issue = args[:issue]
      update_args = args.slice(:summary, :description).compact

      if issue.update(update_args)
        { issue: issue }
      else
        { errors: issue.errors.full_messages }
      end
    end
  end
end
