require 'test_helper'

class FetchOrganizationQueryTest < ActiveSupport::TestCase
  test 'returns null with invalid id' do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            createdAt
            updatedAt
            name
            photoUrl
          }
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => 'invalid' })
    organization_result = result['data']['node']

    assert_nil organization_result
  end

  test 'returns organization with id' do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            createdAt
            updatedAt
            name
            photoUrl
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

  test 'returns organization with user creator' do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            createdAt
            updatedAt
            name
            photoUrl
            userCreator {
              id
            }
          }
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)
    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => organization.node_id })
    organization_result = result['data']['node']

    assert organization_result['userCreator']
    assert organization_result['userCreator']['id']
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
            }
          }
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => organization.node_id })
    organization_result = result['data']['node']

    assert_equal organization_result['projects'].length, organization.projects.length

    organization.projects.each_with_index do |project, index|
      project_result = organization_result['projects'][index]

      assert project_result
      assert project_result['id']
      assert_equal project_result['name'], project.name
    end
  end

  test 'returns organization with memberships' do
    query_string = <<-GRAPHQL
      query fetchOrganizationMemberships($id: ID!) {
        node(id: $id) {
          ...on Organization {
            id
            memberships {
              id
            }
          }
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)

    result = IssueTrackerSchema.execute(query_string, variables: { 'id' => organization.node_id })
    organization_result = result['data']['node']

    assert_equal organization_result['memberships'].length, organization.memberships.length

    organization.memberships.each_with_index do |_project, index|
      project_result = organization_result['memberships'][index]

      assert project_result
      assert project_result['id']
    end
  end
end
