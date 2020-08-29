module Mutations
  class CreateBoardColumnItem < Mutations::BaseMutation
    null true

    argument :user_creator_id, ID, required: true
    argument :column_id, ID, required: true
    argument :issue_id, ID, required: true

    field :column_item, Types::BoardColumnItemType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      column = IssueTrackerSchema.object_from_id(args[:column_id])
      issue = IssueTrackerSchema.object_from_id(args[:issue_id])

      column_item = Projects::BoardColumnItem.create(
        user_creator: user_creator,
        column: column,
        issue: issue
      )

      return { errors: column_item.errors.full_messages } if column_item.invalid?

      {
        column_item: column_item,
        errors: []
      }
    end
  end
end
