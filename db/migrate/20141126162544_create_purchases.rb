# db migration
class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true
      t.float :total

      t.timestamps
    end
  end
end
