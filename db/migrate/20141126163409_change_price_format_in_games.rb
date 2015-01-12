# db migration
class ChangePriceFormatInGames < ActiveRecord::Migration
  def up
    change_column :games, :price, :float
  end

  def down
    change_column :games, :price, :integer
  end
end
