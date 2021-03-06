class IssueTrackerSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  # Stores hash of models by their name for looking up in `.object_from_id/2`
  # `eager_load!` must be called for the models to be retreived
  Rails.application.eager_load!
  @models_by_name = ApplicationRecord.descendants
                                     .map { |model| [model.name, model] }
                                     .to_h

  # Create UUIDs by joining the type name & ID, then base64-encoding it
  def self.id_from_object(object, _type_definition = nil, _query_ctx = {})
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  end

  # Decode object id using UUID created from `.id_from_object/3`
  def self.object_id_from_id(id, _query_ctx = {})
    _model_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
    object_id
  rescue StandardError
    nil
  end

  # Find object in database using UUID created from `.id_from_object/3`
  def self.object_from_id(id, _query_ctx = {})
    model_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
    model = @models_by_name[model_name]

    model&.find(object_id)
  rescue StandardError
    nil
  end

  @types_by_model = {
    Accounts::User => Types::UserType,
    Profiles::Profile => Types::ProfileType,
    Organizations::Organization => Types::OrganizationType,
    Organizations::Membership => Types::MembershipType,
    Projects::Project => Types::ProjectType,
    Projects::Board => Types::BoardType,
    Projects::BoardItem => Types::BoardItemType,
    Projects::BoardColumn => Types::BoardColumnType,
    Projects::Issue => Types::IssueType
  }

  # For telling the schema what type Relay `Node` objects are
  def self.resolve_type(_type, obj, _ctx)
    @types_by_model[obj.class] || raise("Unexpected object: #{obj}")
  end
end
