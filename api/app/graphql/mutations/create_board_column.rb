module Mutations
  class CreateBoardColumn < Mutations::BaseMutation
    description 'Create a new column on a project board.'

    argument :name, String, required: true
    argument :user_creator_id, ID, required: true
    argument :board_id, ID, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      board = IssueTrackerSchema.object_from_id(args[:board_id])

      column = Projects::BoardColumn.create(
        name: args[:name],
        user_creator: user_creator,
        board: board
      )

      if column.invalid?
        { errors: column.errors.full_messages }
      else
        { column: column }
      end
    end
  end
end
