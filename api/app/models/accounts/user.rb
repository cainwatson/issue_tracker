module Accounts
  class User < ApplicationRecord
    include Authenticatable

    has_one :profile, class_name: 'Profiles::Profile'

    has_many :projects, class_name: 'Projects::Project', as: :owner
    has_many :memberships, class_name: 'Organizations::Membership', foreign_key: :user_to
    has_many :organizations_created, class_name: 'Organizations::Organization', foreign_key: :user_creator
  end
end
