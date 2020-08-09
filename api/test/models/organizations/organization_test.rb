require 'test_helper'

class Organizations::OrganizationTest < ActiveSupport::TestCase
  test "name should be present" do
    organization = Organizations::Organization.new(
      user_creator: accounts_users(:tyler),
    )
    assert organization.invalid?

    organization.name = "organization name"
    assert organization.valid?
  end

  test "name should be unique" do
    organization = Organizations::Organization.new(
      user_creator: accounts_users(:tyler),
      name: organizations_organizations(:one).name,
    )
    assert organization.invalid?

    organization.name = "unique organization name"
    assert organization.valid?
  end
end
