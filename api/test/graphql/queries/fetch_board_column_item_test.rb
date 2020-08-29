require 'test_helper'

class FetchBoardColumnItemQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchBoardColumnItem($id: ID!) {
        node(id: $id) {
          ...on BoardColumnItem {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    column_item_result = result['data']['node']

    assert_nil column_item_result
  end

  test 'returns column item with id' do
    query_string = <<-GRAPHQL
      query fetchBoardColumnItem($id: ID!) {
        node(id: $id) {
          ...on BoardColumnItem {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    column_item = projects_board_column_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => column_item.node_id })
    column_item_result = result['data']['node']

    assert column_item_result['id']
    assert column_item_result['createdAt']
    assert column_item_result['updatedAt']
  end

  test 'returns column item with user creator' do
    query_string = <<-GRAPHQL
      query fetchBoardColumnItem($id: ID!) {
        node(id: $id) {
          ...on BoardColumnItem {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    column_item = projects_board_column_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => column_item.node_id })
    column_item_result = result['data']['node']

    assert column_item_result['userCreator']
    assert column_item_result['userCreator']['id']
  end

  test 'returns column item with board column' do
    query_string = <<-GRAPHQL
      query fetchBoardColumnItem($id: ID!) {
        node(id: $id) {
          ...on BoardColumnItem {
            id
            column {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    column_item = projects_board_column_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => column_item.node_id })
    column_item_result = result['data']['node']

    assert column_item_result['column']
    assert column_item_result['column']['id']
    assert_equal column_item_result['column']['name'], column_item.column.name
  end

  test 'returns column item with issue' do
    query_string = <<-GRAPHQL
      query fetchBoardColumnItem($id: ID!) {
        node(id: $id) {
          ...on BoardColumnItem {
            id
            issue {
              id
              summary
            }
          }
        }
      }
    GRAPHQL

    column_item = projects_board_column_items(:tylers_one_todo_1)
    result = graphql_query(query_string, variables: { 'id' => column_item.node_id })
    column_item_result = result['data']['node']

    assert column_item_result['issue']
    assert column_item_result['issue']['id']
    assert_equal column_item_result['issue']['summary'], column_item.issue.summary
  end
end
