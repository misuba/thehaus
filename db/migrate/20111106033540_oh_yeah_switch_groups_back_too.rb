class OhYeahSwitchGroupsBackToo < ActiveRecord::Migration
  def up
    rename_column :groups, :owner_id, :user_id
  end

  def down
    rename_column :groups, :user_id, :owner_id
  end
end
