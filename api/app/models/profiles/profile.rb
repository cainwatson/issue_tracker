class Profiles::Profile < ApplicationRecord
  belongs_to :user, class_name: "Accounts::User"
end
