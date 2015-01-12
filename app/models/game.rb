# class for game
class Game < ActiveRecord::Base
  has_many :comments, dependent: :delete_all
  has_many :ratings, dependent: :delete_all
  has_many :cart_items, dependent: :delete_all
  has_many :purchase_items
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  def edit_description(data)
    self.description = data[:description]
    save
  end

  def edit_price(data)
    self.price = data[:price]
    save
  end

  def edit_genre(data)
    self.genre = data[:genre]
    save
  end

  def add_rating(data)
    ratings.create(user_id: data[:user_id], rating: data[:rating])
  end

  def add_comment(data)
    comments.create(user_id: data[:user_id], content: data[:content])
  end
end
