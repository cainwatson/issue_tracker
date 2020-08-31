module Mutations
  class MoveBoardColumn < Mutations::BaseMutation
    null true

    argument :column_id, ID, required: true
    argument :position, Int, required: true

    field :column, Types::BoardColumnType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      column = IssueTrackerSchema.object_from_id(args[:column_id])

      column.update(board_order_position: args[:position])

      return { errors: column.errors.full_messages } if column.invalid?

      {
        column: column,
        errors: []
      }
    end
  end
end
