module Mutations
  class InviteMember < Mutations::BaseMutation
    description 'Invite a user to an organization.'

    argument :organization_id, String, required: true, loads: Types::OrganizationType
    argument :user_from_id, ID, required: true, loads: Types::UserType
    argument :user_to_id, ID, required: true, loads: Types::UserType

    field :membership, Types::MembershipType, null: true
    field :errors, [String], null: true

    def resolve(organization:, user_from:, user_to:)
      membership = Organizations::Membership.create(
        organization: organization,
        user_from: user_from,
        user_to: user_to,
      )

      if membership.invalid?
        { errors: membership.errors.full_messages }
      else
        { membership: membership }
      end
    end
  end
end
