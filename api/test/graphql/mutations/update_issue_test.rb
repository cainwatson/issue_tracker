require 'test_helper'

class UpdateIssueMutationTest < ActiveSupport::TestCase
  test 'returns updated issue' do
    query_string = <<-GRAPHQL
      mutation updateIssue($input: UpdateIssueInput!) {
        updateIssue(input: $input) {
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
      'issueId' => projects_issues(:megans_one).node_id,
      'summary' => 'I change my mind',
      'description' => "Let's do this instead..."
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    update_issue_result = result['data']['updateIssue']

    assert_nil update_issue_result['errors']

    assert update_issue_result['issue']['id']
    assert update_issue_result['issue']['createdAt']
    assert update_issue_result['issue']['updatedAt']
    assert update_issue_result['issue']['number']
    assert_equal update_issue_result['issue']['summary'], 'I change my mind'
    assert_equal update_issue_result['issue']['description'], "Let's do this instead..."
  end
end
