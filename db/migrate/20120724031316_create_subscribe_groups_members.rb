class CreateSubscribeGroupsMembers < ActiveRecord::Migration
  def change
  	create_table :subscribe_groups_members, :id => false do |t|
	  	t.references :user
	  	t.references :subscribe_group
  	end
  end
end
