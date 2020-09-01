module Mutations
  class CreateBoardColumn < Mutations::BaseMutation
    description 'Create a new column on a project board.'

    argument :name, String, required: true
    argument :user_creator_id, ID, required: true
    argument :board_id, ID, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      board = IssueTrackerSchema.object_from_id(args[:board_id])

      column = Projects::BoardColumn.create(
        name: args[:name],
        user_creator: user_creator,
        board: board
      )

      return { errors: column.errors.full_messages } if column.invalid?

      {
        column: column,
        errors: []
      }
    end
  end
end
