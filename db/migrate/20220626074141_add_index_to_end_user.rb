class AddIndexToEndUser < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :name, :string
    add_index :end_users, :name, unique: true
  end
end
