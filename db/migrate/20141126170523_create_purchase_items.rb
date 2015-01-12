# db migration
class CreatePurchaseItems < ActiveRecord::Migration
  def change
    create_table :purchase_items do |t|
      t.references :purchase, index: true
      t.references :game, index: true
      t.integer :amount
      t.float :price

      t.timestamps
    end
  end
end
