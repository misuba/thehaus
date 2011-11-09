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

  validates :title, :body, :user_id, :perms, :presence => true
  validates :perms, :inclusion => {:in => %w{none all users groups}, :message => "must be none, all, users, or groups"}


  ################################## DOWN TO BUSINESS ####################################

  def readable_by?(usr)
    return updatable_by?(usr) if self.perms == 'none'
    return creatable_by?(usr) if self.perms == 'users'
    return true if self.perms == 'all'

    basket = usr.groups.collect {|grp| grp.cards.where("cards.id = ?", self.id)}.flatten
    basket.length > 0 ? true : false
  end

  def creatable_by?(usr)
    !usr.nil? and usr.is_a? User
  end

  def updatable_by?(usr)
    usr == self.user
  end

  def destroyable_by?(usr)
    updatable_by? usr
  end

  #def groups=(grparr)
  #  return false unless new_record?
  #  grparr.each {|grp| self.add_group grp}
  #end

  #def add_group(grp)
  #  self.group_sharings.build :group => grp
  #end

  def Card.find_titles_for_user(searchstring, usr)
    unless usr.nil?
      found = Card.where("title like ? and (perms = 'all' or perms = 'users' or user_id = ?)", "%#{searchstring}%", usr.id)
      found += usr.groups.collect {|grp| grp.cards.where("title like ?", "%#{searchstring}%")}.flatten.uniq
    else
      found = Card.where("title like ? and (perms = 'all')", "%#{searchstring}%")
    end
    # MUCH too slow for autocomplete
  end

  def Card.find_all_for_user(title, usr)
    unless usr.nil?
      found = Card.where("title = ? and (perms = 'all' or perms = 'users' or user_id = ?)", title, usr.id)
      found += usr.groups.collect {|grp| grp.cards.where("title = ?", title)}.flatten.uniq
    else
      found = Card.where("title = ? and (perms = 'all')", title)
    end
    # slow
  end

end

