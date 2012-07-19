class AddTypeToLogins < ActiveRecord::Migration
  def change
    add_column :logins, :type, :integer

  end
end
