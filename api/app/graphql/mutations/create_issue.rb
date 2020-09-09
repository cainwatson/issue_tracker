module Mutations
  class CreateIssue < Mutations::BaseMutation
    description 'Create a new issue.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :project_id, ID, required: true, loads: Types::ProjectType
    argument :board_ids, [ID], required: false
    argument :summary, String, required: true
    argument :description, String, required: false

    field :issue, Types::IssueType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      issue = Projects::Issue.create(
        summary: args[:summary],
        description: args[:description],
        user_creator: args[:user_creator],
        project: args[:project]
      )

      board_ids = (args[:board_ids] || []).map { |id| IssueTrackerSchema.object_id_from_id(id) }
      board_items = issue.add_to_boards(board_ids)

      if board_items.any?(&:invalid?)
        { errors: board_items.flat_map(&:errors.full_messages) }
      elsif issue.invalid?
        { errors: issue.errors.full_messages }
      else
        { issue: issue }
      end
    end
  end
end
