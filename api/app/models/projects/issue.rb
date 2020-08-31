module Projects
  class Issue < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :project, class_name: 'Projects::Project'

    has_many :board_items, class_name: 'Projects::BoardItem'

    validates :summary, presence: true
    validates :number,
              presence: true,
              uniqueness: {
                scope: :project,
                message: 'should be unique per project'
              }

    before_validation :set_number
    before_save :set_number

    def add_to_boards(board_ids)
      boards = board_ids.map do |board_id|
        {
          board_id: board_id,
          user_creator: user_creator,
          issue: self
        }
      end
      Projects::BoardItem.create(boards)
    end

    private

    def set_number
      return if persisted?

      last = Projects::Issue
             .where(['project_id = ?', project_id])
             .order('number DESC')
             .first
      self.number = last ? last.number + 1 : 1
    end
  end
end
