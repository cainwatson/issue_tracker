module Types
  class MutationType < Types::BaseObject
    field :create_user,
          mutation: Mutations::CreateUser,
          description: 'Create a new user.'

    field :create_organization,
          mutation: Mutations::CreateOrganization,
          description: 'Create a new organization.'

    field :create_project,
          mutation: Mutations::CreateProject,
          description: 'Create a new project.'

    field :create_board,
          mutation: Mutations::CreateBoard,
          description: 'Create a new project board.'

    field :create_issue,
          mutation: Mutations::CreateIssue,
          description: 'Create a new issue.'
  end
end
