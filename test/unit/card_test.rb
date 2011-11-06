require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @abe = User.generate!(:username => 'Abe')
    puts @abe.email
    @ben = User.generate!(:username => 'Ben')
    puts @ben.email
    @cindy = User.generate!(:username => 'Cindy')
    puts @cindy.email

    @boysclub = Group.generate!(:user => @abe, :members => [@abe, @ben])

    @not_for_cindy = Card.generate!(:user => @abe, :perms => 'group', :groups => [@boysclub])

    @not_for_anyone = Card.generate!(:user => @cindy, :perms => 'none')

    @hello_world = Card.generate!(:user => @ben, :perms => 'all')
  end

  context "A card" do
    should "have the groups it was assigned" do
      assert_equal @not_for_cindy.groups.length, 1
      assert_equal @not_for_cindy.groups[0], @boysclub
    end

    should "be addable to multiple groups"

    should "be hideable via the 'none' perm"
      assert_equal Card.find_all_for_user(@not_for_anyone.title, @ben).length, 0
      assert_equal Card.find_all_for_user(@not_for_cindy.title, nil).length, 0
    end

    should "still be visible by its creator no matter what"
      assert_equal Card.find_all_for_user(@not_for_anyone.title, @cindy).length, 1
    end

    should "be visible by the nil user when set to 'all' perms"
      assert_equal Card.find_all_for_user(@hello_world.title, nil).length, 1
    end

    should "be hideable by admins"
  end

  context "A card in a group" do
    should "bar non-members from finding it" do
      assert_equal Card.find_all_for_user(@not_for_cindy.title, @cindy).length, 0
    end

    should "bar autocomplete requests as well" do
      assert_equal Card.find_titles_for_user(@not_for_cindy.title, @cindy).length, 0
    end

    should "show up in the group" do
      assert_equal @boysclub.cards[0], @not_for_cindy
    end
  end

  def teardown
    @abe.destroy
    @ben.destroy
    @cindy.destroy
    @boysclub.destroy
    @not_for_cindy.destroy
  end # "DRY" or whatever... ugh
end
