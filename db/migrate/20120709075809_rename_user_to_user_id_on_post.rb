class RenameUserToUserIdOnPost < ActiveRecord::Migration
  def up
  	change_table :posts do |t|
  		t.rename :user, :user_id
  	end
  end

  def down
  	change_table :posts do |t|
  		t.rename :user_id, :user
  	end
  end
end
