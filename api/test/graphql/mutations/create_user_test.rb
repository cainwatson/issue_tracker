require "test_helper"

class CreateUserMutationTest < ActiveSupport::TestCase
  test "returns created user" do
    query_string = <<-GRAPHQL
      mutation create_user($input: CreateUserInput!) {
        createUser(input: $input) {
          errors
          user {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: {"input" => {}})
    create_user_result = result["data"]["createUser"]

    assert create_user_result["user"]["id"]
    assert create_user_result["user"]["createdAt"]
    assert create_user_result["user"]["updatedAt"]
  end
end
