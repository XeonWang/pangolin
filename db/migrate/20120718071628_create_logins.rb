class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.references :user

      t.timestamps
    end
  end
end
