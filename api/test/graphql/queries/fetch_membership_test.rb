require 'test_helper'

class FetchMembershipQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchMembership($id: ID!) {
        node(id: $id) {
          ...on Membership {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    membership_result = result['data']['node']

    assert_nil membership_result
  end

  test 'returns membership with id' do
    query_string = <<-GRAPHQL
      query fetchMembership($id: ID!) {
        node(id: $id) {
          ...on Membership {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    membership = organizations_memberships(:one)
    result = graphql_query(query_string, variables: { 'id' => membership.node_id })
    membership_result = result['data']['node']

    assert membership_result['id']
    assert membership_result['createdAt']
    assert membership_result['updatedAt']
  end

  test 'returns membership with userFrom and userTo' do
    query_string = <<-GRAPHQL
      query fetchMembership($id: ID!) {
        node(id: $id) {
          ...on Membership {
            id
            userFrom {
              id
            }
            userTo {
              id
            }
          }
        }
      }
    GRAPHQL

    membership = organizations_memberships(:one)
    result = graphql_query(query_string, variables: { 'id' => membership.node_id })
    membership_result = result['data']['node']

    assert membership_result['userFrom']
    assert membership_result['userFrom']['id']
    assert membership_result['userTo']
    assert membership_result['userTo']['id']
  end

  test 'returns membership with organization' do
    query_string = <<-GRAPHQL
      query fetchMembership($id: ID!) {
        node(id: $id) {
          ...on Membership {
            id
            organization {
              id
            }
          }
        }
      }
    GRAPHQL

    membership = organizations_memberships(:one)
    result = graphql_query(query_string, variables: { 'id' => membership.node_id })
    membership_result = result['data']['node']

    assert membership_result['organization']
    assert membership_result['organization']['id']
  end
end
