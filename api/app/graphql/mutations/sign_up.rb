module Mutations
  class SignUp < Mutations::BaseMutation
    description 'Create a new user account.'

    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: false
    argument :photo_url, String, required: false

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, [String], null: true

    def resolve(email:, password:, first_name:, **args)
      user = Accounts::User.new(email: email, password: password)
      profile = Profiles::Profile.new(
        user: user,
        first_name: first_name,
        last_name: args[:last_name],
        photo_url: args[:photo_url]
      )

      if user.save && profile.save
        { user: user, token: user.jwt }
      else
        { errors: user.errors.full_messages + profile.errors.full_messages }
      end
    end
  end
end
