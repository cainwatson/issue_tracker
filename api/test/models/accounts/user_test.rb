require 'test_helper'

module Accounts
  class UserTest < ActiveSupport::TestCase
    test 'validates password' do
      user = Accounts::User.create(email: 'test@test.test', password: 'testpass')
      assert_not user.valid?
    end

    test 'hashes and discards password' do
      password = 'i5uTwEdAJ0HMg4cXMEf4f'
      user = Accounts::User.create(email: 'test@test.test', password: password)
      assert_nil user.password
      assert user.password_digest
      assert_not_equal user.password_digest, password
    end

    test 'allows verifying password' do
      password = 'i5uTwEdAJ0HMg4cXMEf4f'
      user = Accounts::User.create(email: 'test@test.test', password: password)

      assert_not user.valid_password?('incorrectpwd')
      assert user.valid_password?(password)
    end

    test 'generates jti on creation' do
      user = Accounts::User.create(email: 'test@test.test', password: 'i5uTwEdAJ0HMg4cXMEf4f')
      assert user.jti
    end

    test 'create revokable jwt' do
      user = Accounts::User.create(email: 'test@test.test', password: 'i5uTwEdAJ0HMg4cXMEf4f')
      assert user.jwt

      old_jwt = user.jwt
      user.revoke_jwt
      new_jwt = user.jwt

      assert_not_equal new_jwt, old_jwt
      assert_not user.valid_jwt?(old_jwt)
      assert user.valid_jwt?(new_jwt)
    end

    test 'return user from jwt' do
      user = Accounts::User.create(email: 'test@test.test', password: 'i5uTwEdAJ0HMg4cXMEf4f')
      returned_user = Accounts::User.from_jwt(user.jwt)

      assert_equal returned_user, user
    end
  end
end
