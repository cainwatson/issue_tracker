module Mutations
  class UpdateIssue < Mutations::BaseMutation
    argument :summary, String, required: false
    argument :description, String, required: false
    argument :issue_id, ID, required: true

    field :issue, Types::IssueType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      issue_id = IssueTrackerSchema.object_id_from_id(args[:issue_id])
      issue = Projects::Issue.update(
        issue_id,
        summary: args[:summary],
        description: args[:description]
      )

      return { errors: issue.errors.full_messages } if issue.invalid?

      {
        issue: issue,
        errors: []
      }
    end
  end
end
