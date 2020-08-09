class Projects::Project < ApplicationRecord
  belongs_to :user_creator, class_name: "User"
  belongs_to :organization

  validates :name,
    presence: true,
    uniqueness: {
      scope: :organization,
      message: "should be unique per organization"
    }
end
