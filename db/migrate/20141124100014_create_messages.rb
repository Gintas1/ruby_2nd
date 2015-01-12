# db migration
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.text :content
      t.string :topic

      t.timestamps
    end
  end
end
