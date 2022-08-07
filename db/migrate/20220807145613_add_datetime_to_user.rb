class AddDatetimeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_change, :datetime
  end
end
