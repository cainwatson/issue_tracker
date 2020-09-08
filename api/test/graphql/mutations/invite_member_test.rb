require 'test_helper'

class InviteMemberMutationTest < ActiveSupport::TestCase
  test 'returns created membership' do
    query_string = <<-GRAPHQL
      mutation inviteMember($input: InviteMemberInput!) {
        inviteMember(input: $input) {
          errors
          membership {
            id
            createdAt
            updatedAt
            userFrom {
              id
            }
            userTo {
              id
            }
            organization {
              id
            }
          }
        }
      }
    GRAPHQL

    input = {
      'organizationId' => organizations_organizations(:one).node_id,
      'userFromId' => accounts_users(:tyler).node_id,
      'userToId' => accounts_users(:jamie).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    invite_member_result = result['data']['inviteMember']

    assert_nil invite_member_result['errors']

    assert invite_member_result['membership']['id']
    assert invite_member_result['membership']['createdAt']
    assert invite_member_result['membership']['updatedAt']
    assert invite_member_result['membership']['userFrom']['id']
    assert invite_member_result['membership']['userTo']['id']
    assert invite_member_result['membership']['organization']['id']
  end
end
