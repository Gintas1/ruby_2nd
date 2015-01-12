# db migration
class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true
      t.references :game, index: true
      t.integer :amount
      t.float :price

      t.timestamps
    end
  end
end
