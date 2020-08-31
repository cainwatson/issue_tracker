module Projects
  class BoardColumn < ApplicationRecord
    include RankedModel

    ranks :board_order

    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :board, class_name: 'Projects::Board'

    has_many :items, class_name: 'Projects::BoardItem', foreign_key: 'column_id'

    validates :name,
              presence: true,
              uniqueness: {
                scope: :board,
                message: 'should be unique per board'
              }
  end
end
