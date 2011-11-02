class AddRepliesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :in_reply_to, :integer
  end
end
