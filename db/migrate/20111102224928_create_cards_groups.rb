class CreateCardsGroups < ActiveRecord::Migration
  def up
    create_table :cards_groups do |t|
      t.integer :card_id
    end
  end

  def down
    drop_table :cards_groups
  end
end
