require 'test_helper'

module Organizations
  class OrganizationTest < ActiveSupport::TestCase
    test 'name should be present' do
      organization = Organizations::Organization.new(
        user_creator: accounts_users(:tyler)
      )
      assert organization.invalid?

      organization.name = 'organization name'
      assert organization.valid?
    end

    test 'name should be unique' do
      organization = Organizations::Organization.new(
        user_creator: accounts_users(:tyler),
        name: organizations_organizations(:one).name
      )
      assert organization.invalid?

      organization.name = 'unique organization name'
      assert organization.valid?
    end

    test 'membership should be created for creator' do
      organization = Organizations::Organization.create(
        user_creator: accounts_users(:tyler),
        name: 'new organization'
      )
      assert_equal organization.memberships.length, 1
      assert_equal organization.memberships[0].user_to, accounts_users(:tyler)
    end
  end
end
