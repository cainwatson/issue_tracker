require "test_helper"

class FetchOrganizationQueryTest < ActiveSupport::TestCase
  test "returns organization with id" do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        organization(id: $id) {
          id
          name
          photoUrl
          createdAt
          updatedAt
        }
      }
    GRAPHQL

    organization = organizations_organizations(:one)
    result = IssueTrackerSchema.execute(query_string, variables: {"id" => organization.id})
    organization_result = result["data"]["organization"]

    assert_equal organization_result["id"], organization.id.to_s
    assert_equal organization_result["createdAt"], organization.created_at.iso8601
    assert_equal organization_result["updatedAt"], organization.updated_at.iso8601
    assert_equal organization_result["name"], organization.name
    assert_equal organization_result["photoUrl"], organization.photo_url
  end

  test "returns null with invalid id" do
    query_string = <<-GRAPHQL
      query fetchOrganization($id: ID!) {
        organization(id: $id) {
          id
          name
          photoUrl
          createdAt
          updatedAt
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: {"id" => 0})
    organization_result = result["data"]["organization"]

    assert_nil organization_result
  end
end
