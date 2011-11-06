require 'faker'

class User < ActiveRecord::Base
  #create_table "users", :force => true do |t|
  #  t.string   "email",                                 :default => "", :null => false
  #  t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
  #  t.string   "reset_password_token"
  #  t.datetime "reset_password_sent_at"
  #  t.datetime "remember_created_at"
  #  t.integer  "sign_in_count",                         :default => 0
  #  t.datetime "current_sign_in_at"
  #  t.datetime "last_sign_in_at"
  #  t.string   "current_sign_in_ip"
  #  t.string   "last_sign_in_ip"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :owned_groups, :class_name => "Group", :foreign_key => 'owner_id'

  has_many :memberships
  has_many :groups, :through => :memberships

  has_many :cards

  validates_uniqueness_of :username, :email


  #for testing
  def User.generate(stuf=Hash.new)
    self.new({
      :username => Faker::Internet.user_name,
      :email => Faker::Internet.email,
      :password => "f4rfarf",
      :password_confirmation => "f4rfarf"
    }.merge(stuf))
  end
  def User.generate!(stuf=Hash.new)
    guy = self.generate(stuf)
    guy.save
    guy
  end
end
