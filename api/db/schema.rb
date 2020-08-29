# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_828_015_215) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accounts_users', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'organizations_memberships', force: :cascade do |t|
    t.bigint 'user_from_id', null: false
    t.bigint 'user_to_id', null: false
    t.bigint 'organization_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['organization_id'], name: 'index_organizations_memberships_on_organization_id'
    t.index ['user_from_id'], name: 'index_organizations_memberships_on_user_from_id'
    t.index ['user_to_id'], name: 'index_organizations_memberships_on_user_to_id'
  end

  create_table 'organizations_organizations', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'photo_url'
    t.bigint 'user_creator_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_organizations_organizations_on_name', unique: true
    t.index ['user_creator_id'], name: 'index_organizations_organizations_on_user_creator_id'
  end

  create_table 'profiles_profiles', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name'
    t.string 'photo_url'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_profiles_profiles_on_user_id'
  end

  create_table 'projects_board_column_items', force: :cascade do |t|
    t.bigint 'user_creator_id', null: false
    t.bigint 'column_id', null: false
    t.bigint 'issue_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'rank'
    t.index ['column_id'], name: 'index_projects_board_column_items_on_column_id'
    t.index ['issue_id'], name: 'index_projects_board_column_items_on_issue_id'
    t.index ['user_creator_id'], name: 'index_projects_board_column_items_on_user_creator_id'
  end

  create_table 'projects_board_columns', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'user_creator_id', null: false
    t.bigint 'board_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'rank'
    t.index ['board_id'], name: 'index_projects_board_columns_on_board_id'
    t.index %w[name board_id], name: 'index_projects_board_columns_on_name_and_board_id', unique: true
    t.index ['user_creator_id'], name: 'index_projects_board_columns_on_user_creator_id'
  end

  create_table 'projects_boards', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'user_creator_id', null: false
    t.bigint 'project_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[name project_id], name: 'index_projects_boards_on_name_and_project_id', unique: true
    t.index ['project_id'], name: 'index_projects_boards_on_project_id'
    t.index ['user_creator_id'], name: 'index_projects_boards_on_user_creator_id'
  end

  create_table 'projects_issues', force: :cascade do |t|
    t.string 'summary', null: false
    t.text 'description', default: '', null: false
    t.integer 'number', null: false
    t.bigint 'user_creator_id', null: false
    t.bigint 'project_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[number project_id], name: 'index_projects_issues_on_number_and_project_id', unique: true
    t.index ['project_id'], name: 'index_projects_issues_on_project_id'
    t.index ['user_creator_id'], name: 'index_projects_issues_on_user_creator_id'
  end

  create_table 'projects_projects', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'photo_url'
    t.boolean 'is_private', default: false, null: false
    t.bigint 'user_creator_id', null: false
    t.string 'owner_type', null: false
    t.bigint 'owner_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[name owner_id], name: 'index_projects_projects_on_name_and_owner_id', unique: true
    t.index %w[owner_type owner_id], name: 'index_projects_projects_on_owner_type_and_owner_id'
    t.index ['user_creator_id'], name: 'index_projects_projects_on_user_creator_id'
  end

  add_foreign_key 'organizations_memberships', 'accounts_users', column: 'user_from_id'
  add_foreign_key 'organizations_memberships', 'accounts_users', column: 'user_to_id'
  add_foreign_key 'organizations_memberships', 'organizations_organizations', column: 'organization_id'
  add_foreign_key 'organizations_organizations', 'accounts_users', column: 'user_creator_id'
  add_foreign_key 'profiles_profiles', 'accounts_users', column: 'user_id'
  add_foreign_key 'projects_board_column_items', 'accounts_users', column: 'user_creator_id'
  add_foreign_key 'projects_board_column_items', 'projects_board_columns', column: 'column_id'
  add_foreign_key 'projects_board_column_items', 'projects_issues', column: 'issue_id'
  add_foreign_key 'projects_board_columns', 'accounts_users', column: 'user_creator_id'
  add_foreign_key 'projects_board_columns', 'projects_boards', column: 'board_id'
  add_foreign_key 'projects_boards', 'accounts_users', column: 'user_creator_id'
  add_foreign_key 'projects_boards', 'projects_projects', column: 'project_id'
  add_foreign_key 'projects_issues', 'accounts_users', column: 'user_creator_id'
  add_foreign_key 'projects_issues', 'projects_projects', column: 'project_id'
  add_foreign_key 'projects_projects', 'accounts_users', column: 'user_creator_id'
end
