class CreateGroupsUsers < ActiveRecord::Migration
  def up
    create_table :groups_users do |t|
      t.integer :card_id
    end
  end

  def down
    drop_table :cards_groups
  end
end
