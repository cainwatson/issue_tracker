module Mutations
  class RemoveMember < Mutations::BaseMutation
    description 'Remove a user from an organization.'

    argument :organization_id, ID, required: true, loads: Types::OrganizationType
    argument :user_id, ID, required: true, loads: Types::UserType

    field :membership, Types::MembershipType, null: true
    field :errors, [String], null: true

    def resolve(organization:, user:)
      membership = Organizations::Membership.find_by(
        organization: organization,
        user_to: user
      )

      return { errors: ['Membership not found'] } unless membership

      membership = membership.destroy

      if membership.invalid?
        { errors: membership.errors.full_messages }
      else
        { membership: membership }
      end
    end
  end
end
