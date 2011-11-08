require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @abe = FactoryGirl.create(:user, :username => 'Abe')
    @ben = FactoryGirl.create(:user, :username => 'Ben')
    @cindy = FactoryGirl.create(:user, :username => 'Cindy')
    
    @boysclub = FactoryGirl.create(:group, :user => @abe)
    @boysclub.memberships.create :user => @abe
    @boysclub.memberships.create :user => @ben

    @not_for_cindy = FactoryGirl.create(:card, :user => @abe, :perms => 'groups')
    @not_for_cindy.group_sharings.create :group => @boysclub
    
    @cindyspeeps = FactoryGirl.create(:group, :user => @cindy)
    @cindyspeeps.memberships.create :user => FactoryGirl.create(:user)
  end

  context "A group" do
    should "validate properly"

    should "not be addable to a card created by someone not the group's owner" do
      @not_for_cindy.group_sharings.create :group => @cindyspeeps
      assert_equal @not_for_cindy.groups.length, 1
      assert_equal @not_for_cindy.groups[0], @boysclub
    end

    should "add a given user only once" 
  end

  def teardown
    @abe.destroy
    @ben.destroy
    @cindy.destroy
    @boysclub.destroy
    @cindyspeeps.destroy
    @not_for_cindy.destroy
  end
end
