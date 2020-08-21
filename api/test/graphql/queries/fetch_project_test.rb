require 'test_helper'

class FetchProjectQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchProject($id: ID!) {
        node(id: $id) {
          ...on Project {
            id
            createdAt
            updatedAt
            name
            photoUrl
            isPrivate
          }
        }
      }
    GRAPHQL

    result = graphql_query(query_string, variables: { 'id' => 'invalid' })
    project_result = result['data']['node']

    assert_nil project_result
  end

  test 'returns project with id' do
    query_string = <<-GRAPHQL
      query fetchProject($id: ID!) {
        node(id: $id) {
          ...on Project {
            id
            createdAt
            updatedAt
            name
            photoUrl
            isPrivate
          }
        }
      }
    GRAPHQL

    project = projects_projects(:tylers)
    result = graphql_query(query_string, variables: { 'id' => project.node_id })
    project_result = result['data']['node']

    assert project_result['id']
    assert project_result['createdAt']
    assert project_result['updatedAt']
    assert_equal project_result['name'], project.name
    assert_equal project_result['photoUrl'], project.photo_url
    assert_equal project_result['isPrivate'], project.is_private
  end

  test 'returns project with user creator' do
    query_string = <<-GRAPHQL
      query fetchProject($id: ID!) {
        node(id: $id) {
          ...on Project {
            id
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    project = projects_projects(:tylers)
    result = graphql_query(query_string, variables: { 'id' => project.node_id })
    project_result = result['data']['node']

    assert project_result['userCreator']
    assert project_result['userCreator']['id']
  end

  test 'returns project with owner' do
    query_string = <<-GRAPHQL
      query fetchProject($id: ID!) {
        node(id: $id) {
          ...on Project {
            id
            owner {
              ...on Organization {
                id
              }
            }
          }
        }
      }
    GRAPHQL

    project = projects_projects(:org_ones)
    result = graphql_query(query_string, variables: { 'id' => project.node_id })
    project_result = result['data']['node']

    assert project_result['owner']
    assert project_result['owner']['id']
  end
end
