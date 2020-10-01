require 'test_helper'

class PasswordSignInMutationTest < ActiveSupport::TestCase
  test 'returns null when given invalid credentials' do
    query_string = <<-GRAPHQL
      mutation passwordSignIn($input: PasswordSignInInput!) {
        passwordSignIn(input: $input) {
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

    password = 'testpassword'
    user = Accounts::User.create(email: 'test@test.test', password: password)

    input = {
      'email' => user.email,
      'password' => 'incorrectpassword'
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    sign_in_result = result['data']['passwordSignIn']

    assert_equal sign_in_result['errors'], ['Invalid credentials']
    assert_nil sign_in_result['user']
  end

  test 'returns user when given valid credentials' do
    query_string = <<-GRAPHQL
      mutation passwordSignIn($input: PasswordSignInInput!) {
        passwordSignIn(input: $input) {
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

    password = 'testpassword'
    user = Accounts::User.create(email: 'test@test.test', password: password)

    input = {
      'email' => user.email,
      'password' => password
    }
    result = graphql_query(query_string, variables: { 'input' => input })
    sign_in_result = result['data']['passwordSignIn']

    assert_nil sign_in_result['errors']
    assert sign_in_result['user']['id']
    assert sign_in_result['user']['createdAt']
    assert sign_in_result['user']['updatedAt']
    assert_equal sign_in_result['user']['email'], user.email
    assert_equal sign_in_result['token'], user.jwt
  end
end
