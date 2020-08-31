module Mutations
  class MoveBoardItem < Mutations::BaseMutation
    argument :item_id, ID, required: true
    argument :position, Int, required: true

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      item = IssueTrackerSchema.object_from_id(args[:item_id])

      item.update(column_order_position: args[:position])

      return { errors: item.errors.full_messages } if item.invalid?

      {
        item: item,
        errors: []
      }
    end
  end
end
