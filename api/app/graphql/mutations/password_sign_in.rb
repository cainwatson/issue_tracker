module Mutations
  class PasswordSignIn < Mutations::BaseMutation
    description 'Return user with matching credentials.'

    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, [String], null: true

    def resolve(email:, password:)
      user = Accounts::User.find_by(email: email)

      if user&.valid_password?(password)
        { user: user, token: user.jwt }
      else
        { errors: ['Invalid credentials'] }
      end
    end
  end
end
