class ChangeUserKeyInMemberships < ActiveRecord::Migration
  def up
    rename_column :memberships, :member_id, :user_id
  end

  def down
    rename_column :memberships, :user_id, :member_id
  end
end
