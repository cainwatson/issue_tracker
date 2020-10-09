require 'test_helper'

class MoveBoardItemMutationTest < ActiveSupport::TestCase
  test 'returns moved board item' do
    query_string = <<-GRAPHQL
      mutation moveBoardItem($input: MoveBoardItemInput!) {
        moveBoardItem(input: $input) {
          errors
          item {
            id
            createdAt
            updatedAt
            columnPosition
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    new_position = item.column_order_rank + 1
    input = {
      'itemId' => item.node_id,
      'position' => new_position
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    move_board_item_result = result['data']['moveBoardItem']

    assert_nil move_board_item_result['errors']

    assert move_board_item_result['item']['id']
    assert move_board_item_result['item']['createdAt']
    assert move_board_item_result['item']['updatedAt']
    assert_equal move_board_item_result['item']['columnPosition'], new_position
  end

  test 'returns moved board item to another column' do
    query_string = <<-GRAPHQL
      mutation moveBoardItem($input: MoveBoardItemInput!) {
        moveBoardItem(input: $input) {
          errors
          item {
            id
            createdAt
            updatedAt
            columnPosition
            column {
              id
            }
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    new_column = projects_board_columns(:tylers_one_in_progress)
    new_position = 0
    input = {
      'itemId' => item.node_id,
      'columnId' => new_column.node_id,
      'position' => new_position
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    move_board_item_result = result['data']['moveBoardItem']

    assert_nil move_board_item_result['errors']

    assert move_board_item_result['item']['id']
    assert move_board_item_result['item']['createdAt']
    assert move_board_item_result['item']['updatedAt']
    assert_equal move_board_item_result['item']['columnPosition'], new_position
    assert_equal move_board_item_result['item']['column']['id'], new_column.node_id
  end
end
