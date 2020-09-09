module Mutations
  class MoveBoardItem < Mutations::BaseMutation
    description 'Move an item in a column to a new position.'

    argument :item_id, ID, required: true, loads: Types::BoardItemType
    argument :position, Int, required: true

    field :item, Types::BoardItemType, null: true
    field :errors, [String], null: true

    def resolve(item:, position:)
      item.update(column_order_position: position)

      if item.invalid?
        { errors: item.errors.full_messages }
      else
        { item: item }
      end
    end
  end
end
