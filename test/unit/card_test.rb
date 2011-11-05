require 'test_helper'

class CardTest < ActiveSupport::TestCase

  @abe = User.generate!(:username => 'Abe')
  @ben = User.generate!(:username => 'Ben')
  @cindy = User.generate!(:username => 'Cindy')

  @boysclub = Group.generate!(:owner => @abe, :members => [@abe, @ben])

  @not_for_cindy = Card.generate!(:user => @abe, :perms => 'group', :groups => [@boysclub])

  context "A card" do
    should "have the groups it was assigned" do
      assert_equal @not_for_cindy.groups.length, 1
      assert_equal @not_for_cindy.groups[0], @boysclub
    end

    should "be addable to multiple groups"

    should "be hideable via the 'none' perm"

    should "still be visible by its creator no matter what"

    should "be visible by the nil user when set to 'all' perms"

    should "be hideable by admins"
  end

  context "A card in a group" do
    should "bar non-members from finding it" do
      assert_equal Card.find_all_for_user(@not_for_cindy.title, @cindy).length, 0
    end

    should "show up in the group" do
      assert_equal @boysclub.cards[0], @not_for_cindy
    end
  end

end
