# class for cart
class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :delete_all

  def add(data)
    price = Game.find(data[:game_id]).price
    if (item = cart_items.find_by_game_id(data[:game_id])).nil?
      cart_items.create(amount: data[:amount], game_id: data[:game_id],
                             price: price * data[:amount])
    else
      item.amount += data[:amount]
      item.price = price * item.amount
      item.save
    end
    recalculate_total
  end

  def recalculate_total
    self.total = 0
    cart_items.find_each do |item|
      self.total += item.price
    end
  end

  def remove(data)
    cart_items.find_by_game_id(data[:game_id]).destroy!
    save
  end

  def clear_cart
    cart_items.find_each do |item|
      item.destroy
      self.total = 0
    end
    save
  end

  def buy
    return if user.balance < self.total
    purchase = user.purchases.create(total: 0)
    user.balance -= self.total
    cart_items.find_each do |item|
      user.add_game(game_id: item.game_id, amount: item.amount)
      purchase.add_item(game_id: item.game_id, amount: item.amount,
                        price: item.price)
    end
    clear_cart
    user.save
  end
end
