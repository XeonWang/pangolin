class CreateRegists < ActiveRecord::Migration
  def change
    create_table :regists do |t|

      t.timestamps
    end
  end
end
