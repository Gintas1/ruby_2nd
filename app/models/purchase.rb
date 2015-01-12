# class for purchases
class Purchase < ActiveRecord::Base
  belongs_to :user
  has_many :purchase_items, dependent: :delete_all

  def add_item(data)
    purchase_items.create(game_id: data[:game_id], amount: data[:amount])
    self.total += data[:price]
    save
  end
end
