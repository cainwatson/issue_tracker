require 'test_helper'

class MoveBoardColumnMutationTest < ActiveSupport::TestCase
  test 'returns moved board column' do
    query_string = <<-GRAPHQL
      mutation moveBoardColumn($input: MoveBoardColumnInput!) {
        moveBoardColumn(input: $input) {
          errors
          column {
            id
            createdAt
            updatedAt
            boardPosition
          }
        }
      }
    GRAPHQL

    column = projects_board_columns(:tylers_one_todo)
    new_position = column.board_order_rank + 1
    input = {
      'columnId' => column.node_id,
      'position' => new_position
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    move_board_column_result = result['data']['moveBoardColumn']

    assert_equal move_board_column_result['errors'], []

    assert move_board_column_result['column']['id']
    assert move_board_column_result['column']['createdAt']
    assert move_board_column_result['column']['updatedAt']
    assert_equal move_board_column_result['column']['boardPosition'], new_position
  end
end
