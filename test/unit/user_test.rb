require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "usernames should be unique" do
    @loggins = FactoryGirl.create :user, :username => 'loggins'
    assert_equal true, @loggins.valid?

    @messina = FactoryGirl.create :user, :username => 'loggins'
    assert_equal false, @messina.valid?
  end
end
