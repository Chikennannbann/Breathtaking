class RemoveNameFromEndUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :end_users, :name, :string
  end
end
