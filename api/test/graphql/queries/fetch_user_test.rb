require "test_helper"

class FetchUserQueryTest < ActiveSupport::TestCase
  test "returns user with id" do
    query_string = <<-GRAPHQL
      query fetchUser($id: ID!) {
        user(id: $id) {
          id
          createdAt
          updatedAt
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    assert_equal user_result["id"], user.id.to_s
    assert_equal user_result["createdAt"], user.created_at.iso8601
    assert_equal user_result["updatedAt"], user.updated_at.iso8601
  end

  test "returns null with invalid id" do
    query_string = <<-GRAPHQL
      query fetchUser($id: ID!) {
        user(id: $id) {
          id
          createdAt
          updatedAt
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => 0})
    user_result = result["data"]["user"]

    assert_nil user_result
  end

  test "returns user with profile" do
    query_string = <<-GRAPHQL
      query fetchUserProfile($id: ID!) {
        user(id: $id) {
          id
          profile {
            id
            firstName
            lastName
            photoUrl
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    user_profile = profiles_profiles(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    assert_equal user_result["profile"]["id"], user_profile.id.to_s
    assert_equal user_result["profile"]["firstName"], user_profile.first_name
    assert_equal user_result["profile"]["lastName"], user_profile.last_name
    assert_equal user_result["profile"]["photoUrl"], user_profile.photo_url
    assert user_result["profile"]["createdAt"]
    assert user_result["profile"]["updatedAt"]
  end

  test "returns user with projects" do
    query_string = <<-GRAPHQL
      query fetchUserProjects($id: ID!) {
        user(id: $id) {
          id
          projects {
            id
            name
            photoUrl
            isPrivate
            ownerType
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    user.projects.each_with_index do |project, index|
      project_result = user_result["projects"][index]

      assert project_result["id"]
      assert project_result["createdAt"]
      assert project_result["updatedAt"]
      assert_equal project_result["ownerType"], "ACCOUNT"
      assert_equal project_result["name"], project.name
      assert_equal project_result["photoUrl"], project.photo_url
      assert_equal project_result["isPrivate"], project.is_private
    end
  end

  test "returns user with memberships" do
    query_string = <<-GRAPHQL
      query fetchUserMemberships($id: ID!) {
        user(id: $id) {
          id
          memberships {
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
              name
              photoUrl
              createdAt
              updatedAt
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => user.id})
    user_result = result["data"]["user"]

    user.memberships.each_with_index do |membership, index|
      membership_result = user_result["memberships"][index]

      assert membership_result["id"]
      assert membership_result["userFrom"]
      assert membership_result["userTo"]
      assert membership_result["organization"]
      assert membership_result["createdAt"]
      assert membership_result["updatedAt"]

      assert membership_result["organization"]["id"]
      assert membership_result["organization"]["createdAt"]
      assert membership_result["organization"]["updatedAt"]
      assert_equal membership_result["organization"]["name"], membership.organization.name
      assert_equal membership_result["organization"]["photoUrl"], membership.organization.photo_url
    end
  end
end
