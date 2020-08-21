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
  def self.id_from_object(object, type_definition, query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  end

  # Find object in database using UUID created from `.id_from_object/3`
  def self.object_from_id(id, query_ctx)
    model_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
    model = @models_by_name[model_name]

    model && model.find(object_id)
  rescue
    nil
  end

  @types_by_model = {
    Accounts::User => Types::UserType,
    Organizations::Organization => Types::OrganizationType,
    Organizations::Membership => Types::MembershipType,
    Projects::Project => Types::ProjectType,
    Projects::Issue => Types::IssueType,
  }

  # For telling the schema what type Relay `Node` objects are
  def self.resolve_type(type, obj, ctx)
    @types_by_model[obj.class] || raise("Unexpected object: #{obj}")
  end
end
