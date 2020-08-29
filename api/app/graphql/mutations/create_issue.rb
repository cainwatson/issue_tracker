module Mutations
  class CreateIssue < Mutations::BaseMutation
    null true

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
      # TODO: instead, need to create board items;
      # should probably be wrapped in a transaction;
      # and also just a helper method on issue class

      issue = Projects::Issue.create(
        summary: args[:summary],
        description: args[:description],
        user_creator: user_creator,
        project: project
      )

      board_items = (args[:board_ids] || []).map do |board_id|
        board = IssueTrackerSchema.object_from_id(board_id)
        Projects::BoardItem.create(
          user_creator: user_creator,
          board: board,
          issue: issue
        )
      end

      return { errors: board_items[0].errors.full_messages } if board_items.any?(&:invalid?)
      return { errors: issue.errors.full_messages } if issue.invalid?

      {
        issue: issue,
        errors: []
      }
    end
  end
end
