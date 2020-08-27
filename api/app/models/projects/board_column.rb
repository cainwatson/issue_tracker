module Projects
  class BoardColumn < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :board, class_name: 'Projects::Board'

    validates :name,
              presence: true,
              uniqueness: {
                scope: :board,
                message: 'should be unique per board'
              }
  end
end