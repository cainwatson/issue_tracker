module Mutations
  class CreateBoardItem < Mutations::BaseMutation
    description 'Create a new item on a project board.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :board_id, ID, required: true, loads: Types::BoardType
    argument :column_id, ID, required: false, loads: Types::BoardColumnType
    argument :issue_id, ID, required: false, loads: Types::IssueType

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      item = Projects::BoardItem.create(
        user_creator: args[:user_creator],
        board: args[:board],
        column: args[:column],
        issue: args[:issue]
      )

      if item.invalid?
        { errors: item.errors.full_messages } if item.invalid?
      else
        { item: item }
      end
    end
  end
end
