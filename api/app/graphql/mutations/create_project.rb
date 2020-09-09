module Mutations
  class CreateProject < Mutations::BaseMutation
    description 'Create a new project.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :owner_id, ID, required: true, loads: Types::ProjectOwner
    argument :owner_type, Types::ProjectOwnerCategory, required: true
    argument :name, String, required: true
    argument :photo_url, String, required: false
    argument :is_private, Boolean, required: false

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      project = Projects::Project.create(
        name: args[:name],
        photo_url: args[:photo_url],
        is_private: args[:is_private] || false,
        owner: args[:owner],
        user_creator: args[:user_creator]
      )

      if project.invalid?
        { errors: project.errors.full_messages }
      else
        { project: project }
      end
    end
  end
end
