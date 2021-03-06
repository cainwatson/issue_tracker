require 'test_helper'

class FetchBoardQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchBoard($id: ID!) {
        node(id: $id) {
          ...on Board {
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
      query fetchBoard($id: ID!) {
        node(id: $id) {
          ...on Board {
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
      query fetchBoard($id: ID!) {
        node(id: $id) {
          ...on Board {
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
      query fetchBoard($id: ID!) {
        node(id: $id) {
          ...on Board {
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

  test 'returns board with columns' do
    query_string = <<-GRAPHQL
      query fetchBoard($id: ID!) {
        node(id: $id) {
          ...on Board {
            id
            columns {
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

    assert_equal board_result['columns'].length, board.columns.length

    board.columns.each_with_index do |column, index|
      column_result = board_result['columns'][index]

      assert column_result
      assert column_result['id']
      assert_equal column_result['name'], column.name
    end
  end
end
