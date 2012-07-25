class CreateUserClosedPosts < ActiveRecord::Migration
  def change
    create_table :user_closed_posts do |t|
      t.references :user
      t.references :post
      t.string :post_time

      t.timestamps
    end
    add_index :user_closed_posts, :user_id
    add_index :user_closed_posts, :post_id
  end
end
