require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @abe = User.generate!(:username => 'Abe')
    @ben = User.generate!(:username => 'Ben')
    @cindy = User.generate!(:username => 'Cindy')
    
    @boysclub = Group.generate!(:user => @abe, :members => [@abe, @ben])

    @not_for_cindy = Card.generate!(:user => @abe, :perms => 'groups', :groups => [@boysclub])

    @not_for_anyone = Card.generate!(:user => @cindy, :perms => 'none')

    @hello_world = Card.generate!(:user => @ben, :perms => 'all')

    @all_the_young_dudes = Group.generate!(:user => @abe, :members => [User.generate!])

    @in_with_the_in_crowd = Card.generate!(:perms => 'users')
  end

  context "A card" do
    should "have the groups it was assigned" do
      assert_equal 1, @not_for_cindy.groups.length
      assert_equal @boysclub, @not_for_cindy.groups[0]
    end

    should "be addable to multiple groups" do
      @not_for_cindy.add_group @all_the_young_dudes
      @not_for_cindy.save
      assert_equal 2, @not_for_cindy.groups.length
      assert_equal true, @not_for_cindy.readable_by?(@all_the_young_dudes.members[0])
    end

    should "be hideable by admins"

    should "be hideable via the 'none' perm" do
      assert_equal 0, Card.find_all_for_user(@not_for_anyone.title, @ben).length
      assert_equal 0, Card.find_all_for_user(@not_for_cindy.title, nil).length

      assert_equal false, @not_for_anyone.readable_by?(@abe)
    end

    should "not be visible to the nil user when set to users perms" do
      usrlocal = %{@abe @ben @cindy}
      assert_equal true, @in_with_the_in_crowd.readable_by?(usrlocal[rand(usrlocal.length)])
      assert_equal false, @in_with_the_in_crowd.readable_by?(nil)
    end

    should "still be visible by its creator no matter what" do
      assert_equal 1, Card.find_all_for_user(@not_for_anyone.title, @cindy).length
    end

    should "be visible by the nil user when set to all perms" do
      assert_equal 1, Card.find_all_for_user(@hello_world.title, nil).length
      assert_equal true, @hello_world.readable_by?(nil)
    end
  end

  context "A card in a group" do
    should "bar non-members from finding it" do
      assert_equal 0, Card.find_all_for_user(@not_for_cindy.title, @cindy).length
    end

    should "bar autocomplete requests as well" do
      assert_equal 0, Card.find_titles_for_user(@not_for_cindy.title, @cindy).length
    end

    should "show up in the group" do
      assert_equal @not_for_cindy, @boysclub.cards[0]
    end
  end

  def teardown
    @abe.destroy
    @ben.destroy
    @cindy.destroy
    @boysclub.destroy
    @not_for_cindy.destroy
    @all_the_young_dudes.destroy
    @in_with_the_in_crowd.destroy
  end # "DRY" or whatever... ugh
end
