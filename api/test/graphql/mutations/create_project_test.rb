require 'test_helper'

class CreateProjectMutationTest < ActiveSupport::TestCase
  test 'returns created project for account' do
    query_string = <<-GRAPHQL
      mutation createProject($input: CreateProjectInput!) {
        createProject(input: $input) {
          errors
          project {
            id
            createdAt
            updatedAt
            name
            photoUrl
            isPrivate
            userCreator {
              id
            }
            owner {
              ...on User {
                id
              }
            }
            issues {
              id
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    input = {
      'name' => 'My project',
      'ownerType' => 'ACCOUNT',
      'ownerId' => user.node_id,
      'userCreatorId' => user.node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_project_result = result['data']['createProject']

    assert_nil create_project_result['errors']

    assert create_project_result['project']['id']
    assert create_project_result['project']['createdAt']
    assert create_project_result['project']['updatedAt']
    assert create_project_result['project']['userCreator']['id']
    assert create_project_result['project']['owner']['id']
    assert_equal create_project_result['project']['name'], 'My project'
    assert_equal create_project_result['project']['issues'].length, 0
  end

  test 'returns created project for organization' do
    query_string = <<-GRAPHQL
      mutation createProject($input: CreateProjectInput!) {
        createProject(input: $input) {
          errors
          project {
            id
            createdAt
            updatedAt
            name
            photoUrl
            isPrivate
            userCreator {
              id
            }
            owner {
              ...on Organization {
                id
              }
            }
            issues {
              id
            }
          }
        }
      }
    GRAPHQL

    user = accounts_users(:tyler)
    organization = organizations_organizations(:one)
    input = {
      'name' => 'Our project',
      'ownerType' => 'ORGANIZATION',
      'ownerId' => organization.node_id,
      'userCreatorId' => user.node_id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_project_result = result['data']['createProject']

    assert_nil create_project_result['errors']
    assert create_project_result['project']['id']
    assert create_project_result['project']['createdAt']
    assert create_project_result['project']['updatedAt']
    assert create_project_result['project']['userCreator']['id']
    assert create_project_result['project']['owner']['id']
    assert_equal create_project_result['project']['name'], 'Our project'
    assert_equal create_project_result['project']['issues'].length, 0
  end
end
