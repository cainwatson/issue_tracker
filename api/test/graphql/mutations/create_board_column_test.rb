require 'test_helper'

class CreateBoardColumnMutationTest < ActiveSupport::TestCase
  test 'returns created board column' do
    query_string = <<-GRAPHQL
      mutation createBoardColumn($input: CreateBoardColumnInput!) {
        createBoardColumn(input: $input) {
          errors
          column {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    input = {
      'name' => 'Lorem ipsum...',
      'userCreatorId' => accounts_users(:tyler).node_id,
      'boardId' => projects_boards(:tylers_one).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_board_column_result = result['data']['createBoardColumn']

    assert_nil create_board_column_result['errors']

    assert create_board_column_result['column']['id']
    assert create_board_column_result['column']['createdAt']
    assert create_board_column_result['column']['updatedAt']
    assert_equal create_board_column_result['column']['name'], 'Lorem ipsum...'
  end
end
