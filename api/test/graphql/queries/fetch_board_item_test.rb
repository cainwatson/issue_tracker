require 'test_helper'

class FetchBoardItemQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    item_result = result['data']['node']

    assert_nil item_result
  end

  test 'returns item with id' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => item.node_id })
    item_result = result['data']['node']

    assert item_result['id']
    assert item_result['createdAt']
    assert item_result['updatedAt']
  end

  test 'returns item with user creator' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => item.node_id })
    item_result = result['data']['node']

    assert item_result['userCreator']
    assert item_result['userCreator']['id']
  end

  test 'returns item with board' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            board {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => item.node_id })
    item_result = result['data']['node']

    assert item_result['board']
    assert item_result['board']['id']
    assert_equal item_result['board']['name'], item.board.name
  end

  test 'returns item with issue' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            issue {
              id
              summary
            }
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => item.node_id })
    item_result = result['data']['node']

    assert item_result['issue']
    assert item_result['issue']['id']
    assert_equal item_result['issue']['summary'], item.issue.summary
  end

  test 'returns item with column' do
    query_string = <<-GRAPHQL
      query fetchBoardItem($id: ID!) {
        node(id: $id) {
          ...on BoardItem {
            id
            column {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    item = projects_board_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => item.node_id })
    item_result = result['data']['node']

    assert item_result['column']
    assert item_result['column']['id']
    assert_equal item_result['column']['name'], item.column.name
  end
end
