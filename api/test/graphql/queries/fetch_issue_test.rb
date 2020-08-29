require 'test_helper'

class FetchIssueQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchIssue($id: ID!) {
        node(id: $id) {
          ...on Issue {
            id
            createdAt
            updatedAt
            summary
            description
            number
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    issue_result = result['data']['node']

    assert_nil issue_result
  end

  test 'returns issue with id' do
    query_string = <<-GRAPHQL
      query fetchIssue($id: ID!) {
        node(id: $id) {
          ...on Issue {
            id
            createdAt
            updatedAt
            summary
            description
            number
          }
        }
      }
    GRAPHQL

    issue = projects_issues(:megans_one)
    result = graphql_query(query_string, variables: { 'id' => issue.node_id })
    issue_result = result['data']['node']

    assert issue_result['id']
    assert issue_result['createdAt']
    assert issue_result['updatedAt']
    assert_equal issue_result['summary'], issue.summary
    assert_equal issue_result['description'], issue.description
    assert_equal issue_result['number'], issue.number
  end

  test 'returns issue with user creator' do
    query_string = <<-GRAPHQL
      query fetchIssue($id: ID!) {
        node(id: $id) {
          ...on Issue {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    issue = projects_issues(:megans_one)
    result = graphql_query(query_string, variables: { 'id' => issue.node_id })
    issue_result = result['data']['node']

    assert issue_result['userCreator']
    assert issue_result['userCreator']['id']
  end

  test 'returns issue with project' do
    query_string = <<-GRAPHQL
      query fetchIssue($id: ID!) {
        node(id: $id) {
          ...on Issue {
            id
            project {
              id
              name
            }
          }
        }
      }
    GRAPHQL

    issue = projects_issues(:megans_one)
    result = graphql_query(query_string, variables: { 'id' => issue.node_id })
    issue_result = result['data']['node']

    assert issue_result['project']
    assert issue_result['project']['id']
    assert_equal issue_result['project']['name'], issue.project.name
  end

  test 'returns issue with board items' do
    query_string = <<-GRAPHQL
      query fetchIssue($id: ID!) {
        node(id: $id) {
          ...on Issue {
            id
            boardItems {
              id
            }
          }
        }
      }
    GRAPHQL

    issue = projects_issues(:tylers_one)
    result = graphql_query(query_string, variables: { 'id' => issue.node_id })
    issue_result = result['data']['node']

    assert_equal issue_result['boardItems'].length, issue.board_items.length

    issue.board_items.each_with_index do |_board_items, index|
      board_column_item_result = issue_result['boardItems'][index]

      assert board_column_item_result
      assert board_column_item_result['id']
    end
  end
end
