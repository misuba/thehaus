require 'faker'

class Group < ActiveRecord::Base
  #create_table "groups", :force => true do |t|
  #  t.string   "name"
  #  t.integer  "owner_id"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #end

  has_many :group_sharings
  has_many :cards, :through => :group_sharings

  has_many :memberships
  has_many :members, :through => :memberships, :source => :user

  belongs_to :user

  validates :user_id, :presence => true, :numericality => true
  validates :name, :presence => true, :length => {:minimum => 3}

  # for testing
  def Group.generate(stuf=Hash.new)
    self.new({
      :name => Faker::Company.name,
      :user => User.generate
    }.merge(stuf))
  end
  def Group.generate!(stuf=Hash.new)
    guy = self.generate(stuf)
    guy.save
    guy
  end
  
  def readable_by?(usr)
    usr = user
  end

  def creatable_by?(usr)
    !usr.nil? and usr.is_a? User
  end

  def updatable_by?(usr)
    readable_by? usr
  end

  def destroyable_by?(usr)
    readable_by? usr
  end

end
