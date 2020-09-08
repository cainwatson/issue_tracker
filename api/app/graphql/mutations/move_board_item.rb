module Mutations
  class MoveBoardItem < Mutations::BaseMutation
    description 'Move an item in a column to a new position.'

    argument :item_id, ID, required: true
    argument :position, Int, required: true

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      item = IssueTrackerSchema.object_from_id(args[:item_id])

      item.update(column_order_position: args[:position])

      if item.invalid?
        { errors: item.errors.full_messages }
      else
        { item: item }
      end
    end
  end
end
