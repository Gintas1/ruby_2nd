ActiveRecord::Schema.define(version: 201_411_300_857_25) do

  create_table 'cart_items', force: true do |t|
    t.integer 'cart_id'
    t.integer 'game_id'
    t.integer 'amount'
    t.float 'price'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'cart_items', ['cart_id'], name: 'index_cart_items_on_cart_id'
  add_index 'cart_items', ['game_id'], name: 'index_cart_items_on_game_id'

  create_table 'carts', force: true do |t|
    t.integer 'user_id'
    t.float 'total'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'carts', ['user_id'], name: 'index_carts_on_user_id'

  create_table 'comments', force: true do |t|
    t.integer 'game_id'
    t.integer 'user_id'
    t.text 'content'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'comments', ['game_id'], name: 'index_comments_on_game_id'
  add_index 'comments', ['user_id'], name: 'index_comments_on_user_id'

  create_table 'game_lists', force: true do |t|
    t.integer 'user_id'
    t.integer 'game_id'
    t.integer 'amount'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'game_lists', ['game_id'], name: 'index_game_lists_on_game_id'
  add_index 'game_lists', ['user_id'], name: 'index_game_lists_on_user_id'

  create_table 'games', force: true do |t|
    t.string 'name'
    t.string 'description'
    t.string 'genre'
    t.float 'price'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'messages', force: true do |t|
    t.integer 'sender_id'
    t.integer 'recipient_id'
    t.text 'content'
    t.string 'topic'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean 'read'
  end

  add_index 'messages', ['recipient_id'],
            name: 'index_messages_on_recipient_id'
  add_index 'messages', ['sender_id'],
            name: 'index_messages_on_sender_id'

  create_table 'purchase_items', force: true do |t|
    t.integer 'purchase_id'
    t.integer 'game_id'
    t.integer 'amount'
    t.float 'price'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'purchase_items', ['game_id'],
            name: 'index_purchase_items_on_game_id'
  add_index 'purchase_items', ['purchase_id'],
            name: 'index_purchase_items_on_purchase_id'

  create_table 'purchases', force: true do |t|
    t.integer 'user_id'
    t.float 'total'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'purchases', ['user_id'],
            name: 'index_purchases_on_user_id'

  create_table 'ratings', force: true do |t|
    t.integer 'user_id'
    t.integer 'game_id'
    t.integer 'rating'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'ratings', ['game_id'], name: 'index_ratings_on_game_id'
  add_index 'ratings', ['user_id'], name: 'index_ratings_on_user_id'

  create_table 'users', force: true do |t|
    t.string 'username'
    t.string 'password_digest'
    t.float 'balance'
    t.boolean 'blocked'
    t.boolean 'admin'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'token'
    t.string 'email'
    t.string 'activation_token'
    t.boolean 'active'
  end

end
