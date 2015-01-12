require 'rails_helper'

RSpec.describe 'users/show', :type => :view do
  before(:each) do
    assign(:user, FactoryGirl.create(:user))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match /MyString/
  end

  it 'renders email in profile view' do
    render
    expect(rendered).to match /mystring@example.com/
  end

  it 'renders user balance in profile' do
    render
    expect(rendered).to match /0.0/
  end

  it 'it renders user activation status' do
    render
    expect(rendered).to match /inactive/
  end

  it 'it renders user account status' do
    render
    expect(rendered).to match /User/
  end
end
