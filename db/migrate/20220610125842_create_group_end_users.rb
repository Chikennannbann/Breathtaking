class CreateGroupEndUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_end_users do |t|
      t.references :end_user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
