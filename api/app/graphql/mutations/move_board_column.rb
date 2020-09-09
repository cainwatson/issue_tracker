module Mutations
  class MoveBoardColumn < Mutations::BaseMutation
    description 'Move a column on a board to a new position.'

    argument :column_id, ID, required: true, loads: Types::BoardColumnType
    argument :position, Int, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: true

    def resolve(column:, position:)
      column.update(board_order_position: position)

      if column.invalid?
        { errors: column.errors.full_messages }
      else
        { column: column }
      end
    end
  end
end
