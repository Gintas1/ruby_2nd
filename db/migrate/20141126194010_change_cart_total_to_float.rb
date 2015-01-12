# db migration
class ChangeCartTotalToFloat < ActiveRecord::Migration
  def up
    change_column :carts, :total, :float
  end

  def down
    change_column :carts, :total, :integer
  end
end
