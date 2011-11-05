require 'test_helper'

class CardTest < ActiveSupport::TestCase

  setup do
    @abe = User.generate(:username => 'Abe')
    @ben = User.generate(:username => 'Ben')
    @cindy = User.generate(:username => 'Cindy')

    @boysclub = Group.generate(:owner => @abe, :users => [@abe, @ben])

    @not_for_cindy = Card.generate(:user => @abe, :perms => 'group', :groups => [@boysclub])
  end

  context "A card in a group" do
    should "bar non-members from finding it" do

    end
  end
end
