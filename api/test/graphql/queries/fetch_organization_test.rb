require 'test_helper'

class FetchOrganizationQueryTest < ActiveSupport::TestCase
  test 'returns organization with id' do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            name
            photoUrl
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)
    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => organization.node_id })
    organization_result = result['data']['node']

    assert organization_result['id']
    assert organization_result['createdAt']
    assert organization_result['updatedAt']
    assert_equal organization_result['name'], organization.name
    assert_equal organization_result['photoUrl'], organization.photo_url
  end

  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            name
            photoUrl
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => 'invalid' })
    organization_result = result['data']['node']

    assert_nil organization_result
  end

  test 'returns organization with projects' do
    query_string = <<-GRAPHQL
      query fetchOrganizationProjects($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            projects {
              id
              name
              photoUrl
              isPrivate
              ownerType
              createdAt
              updatedAt
            }
          }
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => organization.node_id })
    organization_result = result['data']['node']

    organization.projects.each_with_index do |project, index|
      project_result = organization_result['projects'][index]

      assert project_result['id']
      assert project_result['createdAt']
      assert project_result['updatedAt']
      assert_equal project_result['ownerType'], 'ORGANIZATION'
      assert_equal project_result['name'], project.name
      assert_equal project_result['photoUrl'], project.photo_url
      assert_equal project_result['isPrivate'], project.is_private
    end
  end
end
