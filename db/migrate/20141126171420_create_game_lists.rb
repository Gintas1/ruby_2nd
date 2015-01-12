# db migration
class CreateGameLists < ActiveRecord::Migration
  def change
    create_table :game_lists do |t|
      t.references :user, index: true
      t.references :game, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
