module Projects
  class Board < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :project, class_name: 'Projects::Project'

    has_many :columns, class_name: 'Projects::BoardColumn'

    validates :name,
              presence: true,
              uniqueness: {
                scope: :project,
                message: 'should be unique per project'
              }
  end
end
