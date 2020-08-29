require 'test_helper'

class CreateBoardColumnItemMutationTest < ActiveSupport::TestCase
  test 'returns created column item' do
    query_string = <<-GRAPHQL
      mutation createBoardColumnItem($input: CreateBoardColumnItemInput!) {
        createBoardColumnItem(input: $input) {
          errors
          columnItem {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    input = {
      'userCreatorId' => accounts_users(:tyler).node_id,
      'columnId' => projects_board_columns(:tylers_one_todo).node_id,
      'issueId' => projects_issues(:tylers_three).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_column_item_result = result['data']['createBoardColumnItem']

    assert_equal create_column_item_result['errors'], []

    assert create_column_item_result['columnItem']['id']
    assert create_column_item_result['columnItem']['createdAt']
    assert create_column_item_result['columnItem']['updatedAt']
  end
end
