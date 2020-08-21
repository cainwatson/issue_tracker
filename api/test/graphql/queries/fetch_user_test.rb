require 'test_helper'

class FetchUserQueryTest < ActiveSupport::TestCase
  test 'returns user with id' do
    query_string = <<-GRAPHQL
      query fetchUser($id: ID!) {
        node(id: $id) {
          ...on User {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => user.node_id })
    user_result = result['data']['node']

    assert user_result['id']
    assert user_result['createdAt']
    assert user_result['updatedAt']
  end

  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchUser($id: ID!) {
        node(id: $id) {
          ...on User {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => 'invalid' })
    user_result = result['data']['node']

    assert_nil user_result
  end

  test 'returns user with profile' do
    query_string = <<-GRAPHQL
      query fetchUserProfile($id: ID!) {
        node(id: $id) {
          ...on User {
            id
            profile {
              id
              firstName
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    user_profile = profiles_profiles(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => user.node_id })
    user_result = result['data']['node']

    assert user_result['profile']
    assert user_result['profile']['id']
    assert_equal user_result['profile']['firstName'], user_profile.first_name
  end

  test 'returns user with projects' do
    query_string = <<-GRAPHQL
      query fetchUserProjects($id: ID!) {
        node(id: $id) {
          ...on User {
            id
            projects {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => user.node_id })
    user_result = result['data']['node']

    assert_equal user_result['projects'].length, user.projects.length

    user.projects.each_with_index do |project, index|
      project_result = user_result['projects'][index]

      assert project_result
      assert project_result['id']
      assert_equal project_result['name'], project.name
    end
  end

  test 'returns user with memberships' do
    query_string = <<-GRAPHQL
      query fetchUserMemberships($id: ID!) {
        node(id: $id) {
          ...on User {
            id
            memberships {
              id
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => user.node_id })
    user_result = result['data']['node']

    assert_equal user_result['memberships'].length, user.memberships.length

    user.memberships.each_with_index do |_membership, index|
      membership_result = user_result['memberships'][index]

      assert membership_result
      assert membership_result['id']
    end
  end
end
