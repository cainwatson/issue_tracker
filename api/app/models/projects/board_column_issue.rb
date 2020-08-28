module Projects
  class BoardColumnIssue < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :board_column, class_name: 'Projects::BoardColumn'
    belongs_to :issue, class_name: 'Projects::Issue'
  end
end
