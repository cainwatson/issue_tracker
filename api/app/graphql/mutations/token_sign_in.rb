module Mutations
  class TokenSignIn < Mutations::BaseMutation
    description 'Return user with JWT token.'

    argument :token, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, [String], null: true

    def resolve(token:)
      user = Accounts::User.from_jwt(token)

      if user
        { user: user, token: user.jwt }
      else
        { errors: ['Invalid token'] }
      end
    end
  end
end
