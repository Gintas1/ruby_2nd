require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  it 'adds item to purchase_ list' do
    purchase = FactoryGirl.create(:purchase)
    game = FactoryGirl.create(:game)
    purchase.add_item(game_id: game.id, amount: 2, price: 1.5)
    expect(purchase.purchase_items.count).to eq(1)
  end

end
