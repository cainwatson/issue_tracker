module Mutations
  class MoveBoardColumn < Mutations::BaseMutation
    description 'Move a column on a board to a new position.'

    argument :column_id, ID, required: true
    argument :position, Int, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      column = IssueTrackerSchema.object_from_id(args[:column_id])

      column.update(board_order_position: args[:position])

      if column.invalid?
        { errors: column.errors.full_messages }
      else
        { column: column }
      end
    end
  end
end
