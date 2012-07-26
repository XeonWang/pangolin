class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites, :id => false do |t|
      t.references :user
      t.references :post
    end
    add_index :user_favorites, :user_id
    add_index :user_favorites, :post_id
  end
end
