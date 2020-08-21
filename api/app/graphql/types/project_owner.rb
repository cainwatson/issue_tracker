module Types
  class ProjectOwner < Types::BaseUnion
    description 'An owner of a project.'
    possible_types Types::UserType, Types::OrganizationType
  end
end
