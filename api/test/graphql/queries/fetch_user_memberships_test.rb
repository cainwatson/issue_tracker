require "test_helper"

class FetchUserMembershipsQueryTest < ActiveSupport::TestCase
  test "returns the user's memberships" do
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
