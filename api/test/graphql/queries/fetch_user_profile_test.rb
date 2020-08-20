require "test_helper"

class FetchUserProfileQueryTest < ActiveSupport::TestCase
  test "returns the user's profile" do
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
end
