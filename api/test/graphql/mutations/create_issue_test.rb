require 'test_helper'

class CreateIssueMutationTest < ActiveSupport::TestCase
  test 'returns created issue' do
    query_string = <<-GRAPHQL
      mutation createIssue($input: CreateIssueInput!) {
        createIssue(input: $input) {
          errors
          issue {
            id
            createdAt
            updatedAt
            number
            summary
            description
          }
        }
      }
    GRAPHQL

    input = {
      'summary' => 'Please fix this!',
      'description' => 'Lorem ipsum...',
      'userCreatorId' => accounts_users(:tyler).node_id,
      'projectId' => projects_projects(:tylers).node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_issue_result = result['data']['createIssue']

    assert_equal create_issue_result['errors'], []

    assert create_issue_result['issue']['id']
    assert create_issue_result['issue']['createdAt']
    assert create_issue_result['issue']['updatedAt']
    assert create_issue_result['issue']['number']
    assert_equal create_issue_result['issue']['summary'], 'Please fix this!'
    assert_equal create_issue_result['issue']['description'], 'Lorem ipsum...'
  end
end
