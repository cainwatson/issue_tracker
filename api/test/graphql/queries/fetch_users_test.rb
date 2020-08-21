require 'test_helper'

class FetchUsersQueryTest < ActiveSupport::TestCase
  test 'returns all users' do
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
    users_result = result['data']['users']

    assert_equal users_result.length, Accounts::User.count

    users_result.each do |user_result|
      assert user_result['id']
      assert user_result['createdAt']
      assert user_result['updatedAt']
    end
  end
end
