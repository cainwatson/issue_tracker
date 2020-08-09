class Accounts::User < ApplicationRecord
  has_many :organizations_created, class_name: "Organizations::Organization"
end
