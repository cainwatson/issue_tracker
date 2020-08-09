require "test_helper"

class FetchUserQueryTest < ActiveSupport::TestCase
  test "returns user with id" do
    query_string = <<-GRAPHQL
      query fetch_user($id: ID!) {
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
      query fetch_user($id: ID!) {
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
end
