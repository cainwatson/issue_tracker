module Types
  class ProjectOwnerType < Types::BaseEnum
    value "ACCOUNT", "The project is owned by a user account."
    value "ORGANIZATION", "The project is owned by an organization."
  end
end
