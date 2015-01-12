# db migration
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :description
      t.string :genre
      t.integer :price

      t.timestamps
    end
  end
end
