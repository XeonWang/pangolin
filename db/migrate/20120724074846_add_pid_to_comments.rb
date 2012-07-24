class AddPidToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :p_id, :integer
  end
end
