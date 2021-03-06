module Mutations
  class CreateProject < Mutations::BaseMutation
    description 'Create a new project.'

    argument :user_creator_id, ID, required: true, loads: Types::UserType
    argument :owner_id, ID, required: true, loads: Types::ProjectOwner
    argument :owner_type, Types::ProjectOwnerCategory, required: true
    argument :name, String, required: true
    argument :photo_url, String, required: false
    argument :is_private, Boolean, required: false, default_value: false

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: true

    def resolve(user_creator:, owner:, name:, **args)
      project = Projects::Project.create(
        user_creator: user_creator,
        owner: owner,
        name: name,
        photo_url: args[:photo_url],
        is_private: args[:is_private]
      )

      if project.invalid?
        { errors: project.errors.full_messages }
      else
        { project: project }
      end
    end
  end
end
