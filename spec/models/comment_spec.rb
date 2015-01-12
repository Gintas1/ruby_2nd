require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it 'edits comment content' do
    comment = FactoryGirl.build(:comment)
    comment.edit_content(content: 'new content')
    expect(comment.content).to eq('new content')
  end
end
