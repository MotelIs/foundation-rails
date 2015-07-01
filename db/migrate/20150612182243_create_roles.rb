class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, default: "user"
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :roles, :user_id, unique: true
  end
end
