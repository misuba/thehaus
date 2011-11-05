require 'faker'

class Card < ActiveRecord::Base
  #create_table "cards", :force => true do |t|
  #  t.string   "title"
  #  t.text     "body"
  #  t.integer  "user_id"
  #  t.string   "perms"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #  t.integer  "in_reply_to"
  #end

  belongs_to :user

  has_many :replies, :class_name => 'Card', :foreign_key => 'in_reply_to'

  # has_one :club
  has_many :group_sharings
  has_many :groups, :through => :group_sharings

  validates_presence_of :title, :body, :user, :perms
  

  # for testing
  def Card.generate(stuf=Hash.new)
    self.new({
      :title => Faker::Company.bs, 
      :body => Faker::Lorem.paragraphs.join("\n\n"),
      :user => User.generate,
      :perms => 'all'
    }.merge(stuf))
  end
  def Card.generate!(stuf=Hash.new)
    guy = self.generate(stuf)
    guy.save
    guy
  end

  ################################## DOWN TO BUSINESS ####################################

  def Card.find_titles_for_user(searchstring, user)
    #Card.find_for_user user, "cards.title", ["cards.title LIKE '?'", searchstring]
    found = Card.where("title like '?' and (perms = 'all' #{user.nil? ? "" : "or perms = 'users'"})", searchstring)
    unless user.nil?
      found << user.groups.collect {|grp| grp.cards.where("title like '?'", searchstring)}.flatten.uniq!
    end
    found
    # MUCH too slow for autocomplete
  end

  def Card.find_all_for_user(title, user)
    #Card.find_for_user user, "cards.*", ["cards.title = ?", title]
    found = Card.where("title = ? and (perms = 'all' #{user.nil? ? "" : "or perms = 'users'"})", title)
    unless user.nil?
      found << user.groups.collect {|grp| grp.cards.where("title = ?", title)}.flatten.uniq!
    end
    found
    # slow
  end

end

