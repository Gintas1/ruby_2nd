require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'blocks the user' do
    user = FactoryGirl.build(:user)
    user.stubs(:update_attribute)
    user.expects(:update_attribute).once
    user.block
  end

  it 'unblocks the user' do
    user = FactoryGirl.create(:user)
    user.block
    expect { user.unblock }.to change { user.blocked }.from(true).to(false)
  end

  it 'makes user admin' do
    user = FactoryGirl.create(:user)
    expect { user.make_admin }.to change { user.admin }.from(false).to(true)
  end

  it 'returns received messages' do
    message = FactoryGirl.create(:message)
    user = message.recipient
    expect(user.received_messages.count).to eq(1)
  end

  it 'returns sent messages' do
    message = FactoryGirl.create(:message)
    user = message.sender
    expect(user.sent_messages.count).to eq(1)
  end

  it 'deletes all messages' do
    message = FactoryGirl.create(:message)
    user = message.sender
    expect { user.delete_messages }.to change { user.sent_messages.count }
            .from(1).to(0)
    user.sent_messages.count
  end

  it 'edits user balance' do
    user = FactoryGirl.build(:user)
    expect { user.edit_balance(new_balance: 0) }
            .to change { user.balance }.from(1000).to(0)
  end

  it 'adds to user balance' do
    user = FactoryGirl.create(:user)
    expect { user.add_to_balance(amount: 100) }
        .to change { user.balance }.by(100)
  end

  it 'sends a message' do
    user = FactoryGirl.create(:user)
    expect { user.send_message(recipient: user.id, topic: 't', content: 'c') }
            .to change { user.sent_messages.count }.from(0).to(1)
  end

  it 'adds new game to gamelist' do
    user = FactoryGirl.create(:user)
    user.game_lists.stubs(:find_by_game_id)
    user.game_lists.stubs(:create)
    user.game_lists.expects(:create).with(game_id: 1,amount:  2).once
    user.add_game(game_id: 1, amount: 2)
  end

  it 'adds an existing game to gamelist' do
    game = FactoryGirl.create(:game)
    user = FactoryGirl.create(:user)
    2.times { user.add_game(game_id: game.id, amount: 2) }
    expect(user.game_lists.first.amount).to eq(4)
  end

  it 'active? returns true if user has activated his account' do
    user = FactoryGirl.create(:user)
    user.activate
    expect(user.active?).to be true
  end

  it 'edits game price if user is an admin' do
    user = FactoryGirl.create(:user)
    user.make_admin
    game = mock('game')
    game.expects(:edit_price).with(price: 9.99).once
    user.edit_game_price(game: game, price: 9.99)
  end

  it 'edits description of a game if user is admin' do
    user = FactoryGirl.create(:user)
    user.make_admin
    game = mock('game')
    game.expects(:edit_description).with(description: 'new description').once
    user.edit_game_description(game: game, description: 'new description')
  end

  it 'edits genre of a game if user is an admin' do
    user = FactoryGirl.create(:user)
    user.make_admin
    game = mock('game')
    game.expects(:edit_genre).with(genre: 'new genre').once
    user.edit_game_genre(game: game, genre: 'new genre')
  end

  it 'edits comment content if user is an admin ' do
    user = FactoryGirl.create(:user)
    user.make_admin
    comment = mock('comment')
    comment.expects(:edit_content).with(content: 'new content')
    user.edit_comment_content(comment: comment, content: 'new content')
  end
end
