require 'rails_helper'

RSpec.describe Cart, :type => :model do
  it 'adds item to a cart' do
    cart = FactoryGirl.create(:cart)
    game = FactoryGirl.create(:game)
    expect { cart.add(game_id: game.id, amount: 2) }.to change { cart.total }
            .from(0).to(3)
  end

  it 'adds item to cart that already exists' do
    cart = FactoryGirl.create(:cart)
    game = FactoryGirl.create(:game)
    2.times{ cart.add(game_id: game.id, amount: 2) }
    expect(cart.cart_items.first.amount).to eq(4)
  end

  it 'removes item from a cart' do
    cart = FactoryGirl.create(:cart)
    game = FactoryGirl.create(:game)
    cart.add(game_id: game.id, amount: 2)
    cart.remove(game_id: game.id)
    expect(cart.cart_items.count).to eq(0)
  end

  it 'clears a cart' do
    cart_item = FactoryGirl.create(:cart_item)
    cart = cart_item.cart
    cart.clear_cart
    expect(cart.cart_items.count).to eq(0)
  end



  it 'checks if cart was cleared after buying content of a cart' do

    #Purchase.any_instance.stubs(:add_item)
    cart = FactoryGirl.create(:cart)
    game = FactoryGirl.create(:game)
    cart.add(game_id: game.id, amount: 2)
    user = cart.user
    user.stubs(:add_game)
    user.add_to_balance(amount: 10.0)
    cart.stubs(:clear_cart)
    cart.expects(:clear_cart)
    cart.buy
  end


  it 'checks if bought games were added to a gamelist' do

    #Purchase.any_instance.stubs(:add_item)
    cart = FactoryGirl.create(:cart)
    game = FactoryGirl.create(:game)
    cart.add(game_id: game.id, amount: 2)
    user = cart.user
    user.stubs(:add_game)
    user.add_to_balance(amount: 10.0)
    cart.stubs(:clear_cart)
    user.expects(:add_game)
    cart.buy
  end
end
