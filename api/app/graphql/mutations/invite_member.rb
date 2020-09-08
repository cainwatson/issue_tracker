module Mutations
  class InviteMember < Mutations::BaseMutation
    description 'Invite a user to an organization.'

    argument :organization_id, String, required: true
    argument :user_from_id, ID, required: true
    argument :user_to_id, ID, required: true

    field :membership, Types::MembershipType, null: true
    field :errors, [String], null: true

    def resolve(organization_id:, user_from_id:, user_to_id:)
      membership = Organizations::Membership.create(
        organization_id: IssueTrackerSchema.object_id_from_id(organization_id),
        user_from_id: IssueTrackerSchema.object_id_from_id(user_from_id),
        user_to_id: IssueTrackerSchema.object_id_from_id(user_to_id)
      )

      if membership.invalid?
        { errors: membership.errors.full_messages }
      else
        { membership: membership }
      end
    end
  end
end
