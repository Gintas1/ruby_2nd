# db migration
class ChangeUserBalanceToFloat < ActiveRecord::Migration
  def up
    change_column :users, :balance, :float
  end

  def down
    change_column :users, :balance, :integer
  end
end
