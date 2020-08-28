require 'test_helper'

class FetchProjectBoardQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchProjectBoard($id: ID!) {
        node(id: $id) {
          ...on ProjectBoard {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    board_result = result['data']['node']

    assert_nil board_result
  end

  test 'returns board with id' do
    query_string = <<-GRAPHQL
      query fetchProjectBoard($id: ID!) {
        node(id: $id) {
          ...on ProjectBoard {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    board = projects_boards(:tylers_one)
    result = graphql_query(query_string, variables: { 'id' => board.node_id })
    board_result = result['data']['node']

    assert board_result['id']
    assert board_result['createdAt']
    assert board_result['updatedAt']
    assert_equal board_result['name'], board.name
  end

  test 'returns board with user creator' do
    query_string = <<-GRAPHQL
      query fetchProjectBoard($id: ID!) {
        node(id: $id) {
          ...on ProjectBoard {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    board = projects_boards(:tylers_one)
    result = graphql_query(query_string, variables: { 'id' => board.node_id })
    board_result = result['data']['node']

    assert board_result['userCreator']
    assert board_result['userCreator']['id']
  end

  test 'returns board with project' do
    query_string = <<-GRAPHQL
      query fetchProjectBoard($id: ID!) {
        node(id: $id) {
          ...on ProjectBoard {
            id
            project {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    board = projects_boards(:tylers_one)
    result = graphql_query(query_string, variables: { 'id' => board.node_id })
    board_result = result['data']['node']

    assert board_result['project']
    assert board_result['project']['id']
    assert_equal board_result['project']['name'], board.project.name
  end
end
