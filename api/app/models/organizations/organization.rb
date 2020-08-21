module Organizations
  class Organization < ApplicationRecord
    belongs_to :user_creator, class_name: 'Accounts::User'

    has_many :memberships, class_name: 'Organizations::Membership'
    has_many :projects, class_name: 'Projects::Project', as: :owner

    validates :name, presence: true, uniqueness: true

    after_initialize :add_creator_membership

    private

    def add_creator_membership
      return if persisted?

      memberships.push(
        Organizations::Membership.new(
          user_from: user_creator,
          user_to: user_creator,
          organization: self
        )
      )
    end
  end
end
