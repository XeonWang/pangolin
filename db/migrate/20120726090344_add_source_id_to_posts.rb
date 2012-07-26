class AddSourceIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :source_id, :integer

  end
end
