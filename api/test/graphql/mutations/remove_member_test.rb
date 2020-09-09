require 'test_helper'

class RemoveMemberMutationTest < ActiveSupport::TestCase
  test 'returns created membership' do
    query_string = <<-GRAPHQL
      mutation removeMember($input: RemoveMemberInput!) {
        removeMember(input: $input) {
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
      'userId' => accounts_users(:tyler).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    remove_member_result = result['data']['removeMember']

    assert_nil remove_member_result['errors']

    assert remove_member_result['membership']['id']
    assert remove_member_result['membership']['createdAt']
    assert remove_member_result['membership']['updatedAt']
    assert remove_member_result['membership']['userFrom']['id']
    assert remove_member_result['membership']['userTo']['id']
    assert remove_member_result['membership']['organization']['id']
  end
end
