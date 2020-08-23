module Mutations
  class CreateIssue < Mutations::BaseMutation
    null true

    argument :summary, String, required: true
    argument :description, String, required: false
    argument :user_creator_id, ID, required: true
    argument :project_id, ID, required: true

    field :issue, Types::IssueType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      project = IssueTrackerSchema.object_from_id(args[:project_id])

      issue = Projects::Issue.create(
        summary: args[:summary],
        description: args[:description],
        user_creator: user_creator,
        project: project
      )

      return { errors: issue.errors.full_messages } if issue.invalid?

      {
        issue: issue,
        errors: []
      }
    end
  end
end
