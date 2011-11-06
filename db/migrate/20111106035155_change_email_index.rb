class ChangeEmailIndex < ActiveRecord::Migration
  def up
    remove_index :users, :email
    add_index :users, :email
    add_index :users, :username
  end

  def down
    remove_index :users, :username
    add_index :users, :email
    add_index :users, :email, :unique => true
  end
end
