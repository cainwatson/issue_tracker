class Organization < ApplicationRecord
  belongs_to :user_creator, class_name: "User"

  validates :name, presence: true, uniqueness: true
end
