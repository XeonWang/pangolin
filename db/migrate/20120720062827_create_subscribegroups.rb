class CreateSubscribegroups < ActiveRecord::Migration
  def change
    create_table :subscribe_groups do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :subscribe_groups, :user_id
  end
end
