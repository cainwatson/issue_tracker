require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "name should be present" do
    organization = Organization.new(user_creator: users(:tyler))
    assert organization.invalid?

    organization.name = "organization name"
    assert organization.valid?
  end

  test "name should be unique" do
    existing_organization = organizations(:one)
    organization = Organization.new(user_creator: users(:tyler), name: existing_organization.name)
    assert organization.invalid?

    organization.name = "unique organization name"
    assert organization.valid?
  end
end
