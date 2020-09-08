require 'test_helper'

class CreateBoardItemMutationTest < ActiveSupport::TestCase
  test 'returns created board item' do
    query_string = <<-GRAPHQL
      mutation createBoardItem($input: CreateBoardItemInput!) {
        createBoardItem(input: $input) {
          errors
          item {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    input = {
      'userCreatorId' => accounts_users(:tyler).node_id,
      'boardId' => projects_boards(:tylers_one).node_id,
      'issueId' => projects_issues(:tylers_three).node_id,
      'columnId' => projects_board_columns(:tylers_one_in_progress).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_board_item_result = result['data']['createBoardItem']

    assert_nil create_board_item_result['errors']

    assert create_board_item_result['item']['id']
    assert create_board_item_result['item']['createdAt']
    assert create_board_item_result['item']['updatedAt']
  end
end
