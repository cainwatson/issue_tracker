require 'test_helper'

class FetchBoardColumnQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchBoardColumn($id: ID!) {
        node(id: $id) {
          ...on BoardColumn {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    column_result = result['data']['node']

    assert_nil column_result
  end

  test 'returns column with id' do
    query_string = <<-GRAPHQL
      query fetchBoardColumn($id: ID!) {
        node(id: $id) {
          ...on BoardColumn {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    column = projects_board_columns(:tylers_one_todo)
    result = graphql_query(query_string, variables: { 'id' => column.node_id })
    column_result = result['data']['node']

    assert column_result['id']
    assert column_result['createdAt']
    assert column_result['updatedAt']
    assert_equal column_result['name'], column.name
  end

  test 'returns column with user creator' do
    query_string = <<-GRAPHQL
      query fetchBoardColumn($id: ID!) {
        node(id: $id) {
          ...on BoardColumn {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    column = projects_board_columns(:tylers_one_todo)
    result = graphql_query(query_string, variables: { 'id' => column.node_id })
    column_result = result['data']['node']

    assert column_result['userCreator']
    assert column_result['userCreator']['id']
  end

  test 'returns column with board' do
    query_string = <<-GRAPHQL
      query fetchBoardColumn($id: ID!) {
        node(id: $id) {
          ...on BoardColumn {
            id
            board {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    column = projects_board_columns(:tylers_one_todo)
    result = graphql_query(query_string, variables: { 'id' => column.node_id })
    column_result = result['data']['node']

    assert column_result['board']
    assert column_result['board']['id']
    assert_equal column_result['board']['name'], column.board.name
  end

  test 'returns column with items' do
    query_string = <<-GRAPHQL
      query fetchBoardColumn($id: ID!) {
        node(id: $id) {
          ...on BoardColumn {
            id
            items {
              id
            }
          }
        }
      }
    GRAPHQL

    column = projects_board_columns(:tylers_one_todo)
    result = graphql_query(query_string, variables: { 'id' => column.node_id })
    column_result = result['data']['node']

    assert_equal column_result['items'].length, column.items.length

    column.items.each_with_index do |item, index|
      item_result = column_result['items'][index]

      assert item_result
      assert item_result['id']
      assert_equal item_result['name'], item.name
    end
  end
end
