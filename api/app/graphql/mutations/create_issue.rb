module Mutations
  class CreateIssue < Mutations::BaseMutation
    description 'Create a new issue.'

    argument :summary, String, required: true
    argument :description, String, required: false
    argument :user_creator_id, ID, required: true
    argument :project_id, ID, required: true
    argument :board_ids, [ID], required: false

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

      board_ids = (args[:board_ids] || []).map { |id| IssueTrackerSchema.object_id_from_id(id) }
      board_items = issue.add_to_boards(board_ids)

      return { errors: board_items.flat_map(&:errors.full_messages) } if board_items.any?(&:invalid?)
      return { errors: issue.errors.full_messages } if issue.invalid?

      {
        issue: issue,
        errors: []
      }
    end
  end
end
