module Projects
  class BoardColumnItem < ApplicationRecord
    include RankedModel

    ranks :rank

    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :column, class_name: 'Projects::BoardColumn'
    belongs_to :issue, class_name: 'Projects::Issue'
  end
end
