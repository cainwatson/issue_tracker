class Projects::Project < ApplicationRecord
  belongs_to :user_creator, class_name: "Accounts::User"
  belongs_to :organization, class_name: "Organizations::Organization"

  validates :name,
    presence: true,
    uniqueness: {
      scope: :organization,
      message: "should be unique per organization"
    }
end
