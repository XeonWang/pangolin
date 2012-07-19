class RenameTypeToLogins < ActiveRecord::Migration
  def up
  	rename_column :logins, :type, :action
  end

  def down
  	rename_column :logins, :action, :type
  end
end
