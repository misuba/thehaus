require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @abe = User.generate!(:username => 'Abe')
    @ben = User.generate!(:username => 'Ben')
    @cindy = User.generate!(:username => 'Cindy')
    
    @boysclub = Group.generate!(:user => @abe, :members => [@abe, @ben])
    @cindyspeeps = Group.generate!(:user => @cindy, :members => [User.generate!])

    @not_for_cindy = Card.generate!(:user => @abe, :perms => 'groups', :groups => [@boysclub])

  end

  context "A group" do
    should "validate properly"

    should "not be addable to a card created by someone not the group's owner" do
      @not_for_cindy.groups << @cindyspeeps
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
