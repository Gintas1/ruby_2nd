# class for application user
class User < ActiveRecord::Base
  has_many :messages
  has_many :comments
  has_many :ratings
  has_many :purchases
  has_many :game_lists, dependent: :delete_all
  has_many :games, through: :game_lists
  has_one :cart, autosave: true, dependent: :delete
  has_secure_password
  USERNAME_REGEX = /[a-zA-Z0-9]/
  EMAIL_REGEX = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/
  after_create :default_values
  before_save { self.email = email.downcase }
  before_create :create_token
  before_destroy :delete_messages
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: USERNAME_REGEX },
                       length: { minimum: 3, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX }

  def sent_messages
    Message.where(sender_id: id)
  end

  def default_values
    self.admin = false
    self.blocked = false
    self.active = false
    self.balance = 0
    save
  end

  def delete_messages
    messages = sent_messages
    messages.each(&:destroy)
    messages = received_messages
    messages.each(&:destroy)
  end

  def match_activation_token?(token)
    activation_token == token
  end

  def received_messages
    Message.where(recipient_id: id)
  end

  def active?
    active
  end

  def blocked?
    blocked
  end

  def admin?
    admin
  end

  def activate
    update_attribute(:active, true)
  end

  def make_admin
    update_attribute(:admin, true)
  end

  def block
    update_attribute(:blocked, true)
  end

  def edit_balance(data)
    update_attribute(:balance, data[:new_balance])
  end

  def add_to_balance(data)
    balance = data[:amount] + self.balance
    update_attribute(:balance, balance)
  end

  def unblock
    update_attribute(:blocked, false)
  end

  def send_message(data)
    Message.create(sender_id: id, recipient_id: data[:recipient],
                   content: data[:content], topic: data[:topic])
  end

  def add_game(data)
    if (game = game_lists.find_by_game_id(data[:game_id])).nil?
      game_lists.create(game_id: data[:game_id], amount: data[:amount])
    else
      game.amount += data[:amount]
      game.save
    end
  end

  def edit_game_description(data)
    return unless admin?
    data[:game].edit_description(description: data[:description])
  end

  def edit_game_price(data)
    return unless admin?
    data[:game].edit_price(price: data[:price])
  end

  def edit_game_genre(data)
    return unless admin?
    data[:game].edit_genre(genre: data[:genre])
  end

  def edit_comment_content(data)
    return unless admin?
    data[:comment].edit_content(content: data[:content])
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.authenticate(data)
    user = User.find_by_username(data[:username])
    if user && user.authenticate(data[:password])
      if user.blocked?
        'This user is blocked!'
      else
        user
      end
    else
      'Invalid username and/or password'
    end
  end

  private

  def create_token
    self.token = User.digest(User.new_token)
    self.activation_token = User.digest(User.new_token)
  end
end
