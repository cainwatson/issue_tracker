module Profiles
  class Profile < ApplicationRecord
    belongs_to :user, class_name: 'Accounts::User'
  end
end
