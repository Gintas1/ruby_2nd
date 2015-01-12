require 'rails_helper'

RSpec.describe Game, :type => :model do
  it 'edits game description' do
    game = FactoryGirl.build(:game)
    game.edit_description(description: 'new description')
    expect(game.description).to eq('new description')
  end

  it 'edits game price' do
    game = FactoryGirl.build(:game)
    game.edit_price(price: 10.0)
    expect(game.price).to eq(10.0)
  end

  it 'edits game genre' do
    game = FactoryGirl.build(:game)
    game.edit_genre(genre:'action')
    expect(game.genre).to eq('action')
  end

  it 'adds rating to a game' do
    game = FactoryGirl.create(:game)
    rating = mock('rating')
    game.stubs(:ratings).returns(rating)
    rating.expects(:create).with(user_id: 1, rating: 4)
    game.add_rating(user_id: 1, rating: 4)
  end

  it 'adds comment to a game' do
    game = FactoryGirl.create(:game)
    comment = mock('comment')
    game.stubs(:comments).returns(comment)
    comment.expects(:create).with(user_id: 1, content: 'comment')
    game.add_comment(user_id: 1, content: 'comment')
  end
end
