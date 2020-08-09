class Organizations::Organization < ApplicationRecord
  belongs_to :user_creator, class_name: "Accounts::User"

  validates :name, presence: true, uniqueness: true
end
