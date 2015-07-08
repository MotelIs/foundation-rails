class AddPartiallyRegisteredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :partially_registered, :boolean, default: false
  end
end
