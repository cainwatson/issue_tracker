module Projects
  class Issue < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :project, class_name: 'Projects::Project'

    validates :summary, presence: true
    validates :number,
              presence: true,
              uniqueness: {
                scope: :project,
                message: 'should be unique per project'
              }

    before_validation :set_number
    before_save :set_number

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
