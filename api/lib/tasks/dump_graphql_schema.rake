schema_path = "app/graphql/schema.graphql"


desc "Generates GraphQL Schema and places it in #{schema_path}"
task dump_graphql_schema: :environment do
  # Get a string containing the definition in GraphQL IDL:
  schema_definition = IssueTrackerSchema.to_definition
  # Choose a place to write the schema dump:
  # Write the schema dump to that file:
  File.write(Rails.root.join(schema_path), schema_definition)
  puts "Updated #{schema_path}"
end
