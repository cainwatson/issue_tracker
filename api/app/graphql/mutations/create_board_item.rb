module Mutations
  class CreateBoardItem < Mutations::BaseMutation
    description 'Create a new item on a project board.'

    argument :user_creator_id, ID, required: true
    argument :board_id, ID, required: true
    argument :column_id, ID, required: false
    argument :issue_id, ID, required: false

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      board = IssueTrackerSchema.object_from_id(args[:board_id])
      column = IssueTrackerSchema.object_from_id(args[:column_id])
      issue = IssueTrackerSchema.object_from_id(args[:issue_id])

      item = Projects::BoardItem.create(
        user_creator: user_creator,
        board: board,
        column: column,
        issue: issue
      )

      return { errors: item.errors.full_messages } if item.invalid?

      {
        item: item,
        errors: []
      }
    end
  end
end
