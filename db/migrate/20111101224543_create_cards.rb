class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.string :perms

      t.timestamps
    end
  end
end
