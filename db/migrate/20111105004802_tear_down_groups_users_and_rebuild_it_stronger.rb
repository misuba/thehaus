class TearDownGroupsUsersAndRebuildItStronger < ActiveRecord::Migration
  def up
    drop_table :groups_users
    drop_table :cards_groups
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :member_id
      t.timestamps
    end
    create_table :group_sharings do |t|
      t.integer :group_id
      t.integer :card_id
      t.timestamps
    end
  end

  def down
    drop_table :memberships
    drop_table :group_sharings
    create_table :groups_users do |t|
      t.integer :group_id
      t.integer :user_id
    end
    create_table :cards_groups do |t|
      t.integer :group_id
      t.integer :card_id
    end
  end
end
