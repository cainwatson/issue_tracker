require 'test_helper'

class UpdateOrganizationMutationTest < ActiveSupport::TestCase
  test 'returns updated organization' do
    query_string = <<-GRAPHQL
      mutation updateOrganization($input: UpdateOrganizationInput!) {
        updateOrganization(input: $input) {
          errors
          organization {
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
    input = {
      'organizationId' => organization.node_id,
      'name' => 'New org name',
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    update_organization_result = result['data']['updateOrganization']

    assert_equal update_organization_result['errors'], []

    assert update_organization_result['organization']['id']
    assert update_organization_result['organization']['createdAt']
    assert update_organization_result['organization']['updatedAt']
    assert_equal update_organization_result['organization']['name'], 'New org name'
    assert_equal update_organization_result['organization']['photoUrl'], organization.photo_url
  end
end
