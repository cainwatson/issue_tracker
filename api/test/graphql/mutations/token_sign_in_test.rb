require 'test_helper'

class TokenSignInMutationTest < ActiveSupport::TestCase
  test 'returns null when given invalid token' do
    query_string = <<-GRAPHQL
      mutation tokenSignIn($input: TokenSignInInput!) {
        tokenSignIn(input: $input) {
          errors
          token
          user {
            id
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL

    input = {
      'token' => 'invalid token'
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    sign_in_result = result['data']['tokenSignIn']

    assert_equal sign_in_result['errors'], ['Invalid token']
    assert_nil sign_in_result['token']
    assert_nil sign_in_result['user']
  end

  test 'returns user when given valid token' do
    query_string = <<-GRAPHQL
      mutation tokenSignIn($input: TokenSignInInput!) {
        tokenSignIn(input: $input) {
          errors
          token
          user {
            id
            createdAt
            updatedAt
            email
          }
        }
      }
    GRAPHQL

    user = accounts_users(:megan)
    input = {
      'token' => user.jwt
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    sign_in_result = result['data']['tokenSignIn']

    assert_nil sign_in_result['errors']
    assert sign_in_result['user']['id']
    assert sign_in_result['user']['createdAt']
    assert sign_in_result['user']['updatedAt']
    assert_equal sign_in_result['user']['email'], user.email
    assert_equal sign_in_result['token'], user.jwt
  end
end
