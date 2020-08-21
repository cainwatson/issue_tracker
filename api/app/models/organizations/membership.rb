module Organizations
  class Membership < ApplicationRecord
    belongs_to :user_from, class_name: 'Accounts::User'
    belongs_to :user_to, class_name: 'Accounts::User'
    belongs_to :organization, class_name: 'Organizations::Organization'
  end
end
