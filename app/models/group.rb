require 'faker'

class Group < ActiveRecord::Base
  #create_table "groups", :force => true do |t|
  #  t.string   "name"
  #  t.integer  "owner_id"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #end

  has_and_belongs_to_many :cards
  has_and_belongs_to_many :members, :class_name => 'User', :foreign_key => 'user_id'

  belongs_to :owner, :class_name => 'User'

  # for testing
  def Group.generate(stuf=Hash.new)
    self.new({
      :name => Faker::Company.name,
      :owner => User.generate
    }.merge(stuf))
  end
  
end
