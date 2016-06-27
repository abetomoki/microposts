class CreateFavoriteRelationships < ActiveRecord::Migration
  def change
    create_table :favorite_relationships do |t|
      t.references :user, index: true
      t.references :micropost, index: true

      t.timestamps null: false
      # t.index [:user_id, :micropost_id], unique: true
    end
  end
end
