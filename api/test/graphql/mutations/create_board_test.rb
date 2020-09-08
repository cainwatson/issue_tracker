require 'test_helper'

class CreateBoardMutationTest < ActiveSupport::TestCase
  test 'returns created board' do
    query_string = <<-GRAPHQL
      mutation createBoard($input: CreateBoardInput!) {
        createBoard(input: $input) {
          errors
          board {
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
      'projectId' => projects_projects(:tylers).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_board_result = result['data']['createBoard']

    assert_nil create_board_result['errors']

    assert create_board_result['board']['id']
    assert create_board_result['board']['createdAt']
    assert create_board_result['board']['updatedAt']
    assert_equal create_board_result['board']['name'], 'Lorem ipsum...'
  end
end
