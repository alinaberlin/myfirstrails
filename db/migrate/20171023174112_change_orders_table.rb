class ChangeOrdersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :user_id, :integer
    remove_column :orders, :user, :string
  end
end
