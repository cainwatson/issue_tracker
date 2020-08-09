class Accounts::User < ApplicationRecord
  has_many :projects, class_name: "Projects::Project", as: :owner
  has_many :organizations_created, class_name: "Organizations::Organization"
end
