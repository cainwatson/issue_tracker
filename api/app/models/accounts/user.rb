class Accounts::User < ApplicationRecord
  has_many :projects, class_name: "Projects::Project", as: :owner
  has_many :memberships, class_name: "Organizations::Membership", as: :user_to
  has_many :organizations_created, class_name: "Organizations::Organization"
end
