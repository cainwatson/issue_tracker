module Mutations
  class CreateProject < Mutations::BaseMutation
    description 'Create a new project.'

    argument :name, String, required: true
    argument :photo_url, String, required: false
    argument :is_private, Boolean, required: false
    argument :owner_type, Types::ProjectOwnerCategory, required: true
    argument :owner_id, ID, required: true
    argument :user_creator_id, ID, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: true

    def resolve(**args)
      user_creator = IssueTrackerSchema.object_from_id(args[:user_creator_id])
      owner = IssueTrackerSchema.object_from_id(args[:owner_id])

      project = Projects::Project.create(
        name: args[:name],
        photo_url: args[:photo_url],
        is_private: args[:is_private] || false,
        owner: owner,
        user_creator: user_creator
      )

      if project.invalid?
        { errors: project.errors.full_messages }
      else
        { project: project }
      end
    end
  end
end
