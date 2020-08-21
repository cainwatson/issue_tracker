require "test_helper"

class FetchUsersQueryTest < ActiveSupport::TestCase
  test "returns all users" do
    query_string = <<-GRAPHQL
      query fetchUsers {
        users {
          id
          createdAt
          updatedAt
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string)
    users_result = result["data"]["users"]

    assert_equal users_result[0]["id"], accounts_users[0].id.to_s
    assert_equal users_result[1]["id"], accounts_users[1].id.to_s
  end
end
