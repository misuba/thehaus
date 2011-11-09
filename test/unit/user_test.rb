require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "usernames should be unique" do
    @loggins = FactoryGirl.create :user, :username => 'loggins'

    assert_raise ActiveRecord::RecordInvalid do
      @messina = FactoryGirl.create :user, :username => 'loggins'
    end
  end

  test "emails should be unique" do
    @martin = FactoryGirl.create :user, :email => 'dean@ratpack.org'

    assert_raise ActiveRecord::RecordInvalid do
      @lewis = FactoryGirl.create :user, :email => 'dean@ratpack.org'
    end
  end
end
