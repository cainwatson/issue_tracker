class Organizations::Organization < ApplicationRecord
  belongs_to :user_creator, class_name: "Accounts::User"

  has_many :memberships, class_name: "Organizations::Membership"
  has_many :projects, class_name: "Projects::Project", as: :owner

  validates :name, presence: true, uniqueness: true
end
