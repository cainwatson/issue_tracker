module Mutations
  class TokenSignIn < Mutations::BaseMutation
    description 'Create a new user.'

    argument :token, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(token:)
      user = Accounts::User.from_jwt(token)

      if user
        { user: user }
      else
        { errors: ['Invalid token'] }
      end
    end
  end
end
