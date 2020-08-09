require "test_helper"

class CreateOrganizationMutationTest < ActiveSupport::TestCase
  test "returns created organization" do
    query_string = <<-GRAPHQL
      mutation createOrganization($input: CreateOrganizationInput!) {
        createOrganization(input: $input) {
          errors
          organization {
            id
            userCreatorId
            name
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    result = IssueTrackerSchema.execute(query_string, variables: {"input" => {
      "name" => "My New Org",
      "userCreatorId" => accounts_users(:tyler).id
    }})
    create_organization_result = result["data"]["createOrganization"]

    assert create_organization_result["organization"]["id"]
    assert create_organization_result["organization"]["createdAt"]
    assert create_organization_result["organization"]["updatedAt"]
    assert_equal create_organization_result["organization"]["name"], "My New Org"
    assert_equal create_organization_result["organization"]["userCreatorId"], accounts_users(:tyler).id
  end
end
