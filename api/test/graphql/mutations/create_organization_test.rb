require 'test_helper'

class CreateOrganizationMutationTest < ActiveSupport::TestCase
  test 'returns created organization' do
    query_string = <<-GRAPHQL
      mutation createOrganization($input: CreateOrganizationInput!) {
        createOrganization(input: $input) {
          errors
          organization {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
    GRAPHQL

    input = {
      'name' => 'My New Org',
      'userCreatorId' => accounts_users(:tyler).id
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    create_organization_result = result['data']['createOrganization']

    assert_equal create_organization_result['errors'], []

    assert create_organization_result['organization']['id']
    assert create_organization_result['organization']['createdAt']
    assert create_organization_result['organization']['updatedAt']
    assert_equal create_organization_result['organization']['name'], 'My New Org'
  end
end
