module Projects
  class Project < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'
    belongs_to :owner, polymorphic: true

    has_many :issues, class_name: 'Projects::Issue'

    validates :name,
              presence: true,
              uniqueness: {
                scope: :owner,
                message: 'should be unique per owner'
              }
  end
end
