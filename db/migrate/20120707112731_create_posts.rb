class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user
      t.text :content

      t.timestamps
    end
  end
end
