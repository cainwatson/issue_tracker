module Mutations
  class CreateBoardColumn < Mutations::BaseMutation
    description 'Create a new column on a project board.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :board_id, ID, required: true, loads: Types::BoardType
    argument :name, String, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: true

    def resolve(user_creator:, board:, name:)
      column = Projects::BoardColumn.create(
        name: name,
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
