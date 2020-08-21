module Mutations
  class CreateUser < Mutations::BaseMutation
    null true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve
      { user: Accounts::User.create, errors: [] }
    end
  end
end
