module Projects
  class BoardItem < ApplicationRecord
    include RankedModel

    ranks :column_order, with_same: :column_id

    default_scope { rank(:column_order) }

    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :board, class_name: 'Projects::Board'
    belongs_to :column, class_name: 'Projects::BoardColumn', optional: true
    belongs_to :issue, class_name: 'Projects::Issue', optional: true
  end
end
