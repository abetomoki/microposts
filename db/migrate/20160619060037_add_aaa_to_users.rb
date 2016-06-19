class AddAaaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :biography, :string
    add_column :users, :location, :string
  end
end
