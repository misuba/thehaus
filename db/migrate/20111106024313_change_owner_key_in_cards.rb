class ChangeOwnerKeyInCards < ActiveRecord::Migration
  def up
    rename_column :cards, :user_id, :creator_id
  end

  def down
    rename_column :cards, :creator_id, :user_id
  end
end
