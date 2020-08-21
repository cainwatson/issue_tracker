require 'test_helper'

class FetchProfileQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchProfile($id: ID!) {
        node(id: $id) {
          ...on Profile {
            id
            createdAt
            updatedAt
            firstName
            lastName
            photoUrl
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    profile_result = result['data']['node']

    assert_nil profile_result
  end

  test 'returns profile with id' do
    query_string = <<-GRAPHQL
      query fetchProfile($id: ID!) {
        node(id: $id) {
          ...on Profile {
            id
            createdAt
            updatedAt
            firstName
            lastName
            photoUrl
          }
        }
      }
    GRAPHQL

    profile = profiles_profiles(:tyler)
    result = graphql_query(query_string, variables: { 'id' => profile.node_id })
    profile_result = result['data']['node']

    assert profile_result['id']
    assert profile_result['createdAt']
    assert profile_result['updatedAt']
    assert_equal profile_result['firstName'], profile.first_name
    assert_equal profile_result['lastName'], profile.last_name
    assert_equal profile_result['photoUrl'], profile.photo_url
  end

  test 'returns profile with user' do
    query_string = <<-GRAPHQL
      query fetchProfile($id: ID!) {
        node(id: $id) {
          ...on Profile {
            id
            user {
              id
            }
          }
        }
      }
    GRAPHQL

    profile = profiles_profiles(:tyler)
    result = graphql_query(query_string, variables: { 'id' => profile.node_id })
    profile_result = result['data']['node']

    assert profile_result['user']
    assert profile_result['user']['id']
  end
end
