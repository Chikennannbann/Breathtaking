class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :caption, null: false
      t.string :destination, null: false
      t.date :date, null: false
      t.integer :owner_id, null: false

      t.timestamps
    end
  end
end
