module Mutations
  class MoveBoardItem < Mutations::BaseMutation
    description 'Move an item to a new position or a new column.'

    argument :item_id, ID, required: true, loads: Types::BoardItemType
    argument :column_id, ID, required: false, loads: Types::BoardColumnType
    argument :position, Int, required: true

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: true

    def resolve(item:, position:, **args)
      if args[:column]
        item.update(
          column_order_position: position,
          column: args[:column]
        )
      else
        item.update(column_order_position: position)
      end

      if item.invalid?
        { errors: item.errors.full_messages }
      else
        { item: item }
      end
    end
  end
end
