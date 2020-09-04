require 'test_helper'

class SignUpMutationTest < ActiveSupport::TestCase
  test 'returns signed up user and token' do
    query_string = <<-GRAPHQL
      mutation signUp($input: SignUpInput!) {
        signUp(input: $input) {
          errors
          token
          user {
            id
            createdAt
            updatedAt
            email
            profile {
              firstName
              lastName
              photoUrl
            }
          }
        }
      }
    GRAPHQL

    input = {
      'email' => 'lauren@test.test',
      'password' => 'laurenpwd',
      'firstName' => 'lauren',
      'lastName' => 'olamina',
      'photoUrl' => 'https://...'
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    sign_up_result = result['data']['signUp']

    assert_nil sign_up_result['errors'], []
    assert sign_up_result['token']
    assert sign_up_result['user']['id']
    assert sign_up_result['user']['createdAt']
    assert sign_up_result['user']['updatedAt']
    assert_equal sign_up_result['user']['email'], 'lauren@test.test'
    assert_equal sign_up_result['user']['profile']['firstName'], 'lauren'
    assert_equal sign_up_result['user']['profile']['lastName'], 'olamina'
    assert_equal sign_up_result['user']['profile']['photoUrl'], 'https://...'
  end
end
