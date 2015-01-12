require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let!(:user) {FactoryGirl.create(:user)}
  describe 'create' do
    it 'creates new session with valid parameters' do
      user = FactoryGirl.create(:mike)
      controller.expects(:sign_in).with(user, nil)
      post :create, { session: { username:'mike', password:'MyString' } }
    end
    it 'fails to create a new session for a blocked user' do
      user = mock('user')
      User.stubs(:find_by_username).returns(user)
      user.stubs(:authenticate).returns(true)
      user.stubs(:blocked?).returns(true)
      post :create, { session: { username: '', password: '' } }
      expect(subject.request.flash[:error]).to eq('This user is blocked!')
    end
    it 'fails to create a session with invalid parameters' do
      user = mock('user')
      User.stubs(:find_by_username).returns(user)
      user.stubs(:authenticate).returns(false)
      post :create, { session: { username: 'MyString', password: 'MyStr' } }
      expect(subject.request.flash[:error])
             .to eq('Invalid username and/or password')
    end
  end

  describe 'destroy' do
    it 'redirects user to home page after destroying session' do
      post :create, { session: { username: 'MyString', password: 'MyString' } }
      delete :destroy
      expect(response).to redirect_to(home_path)
    end
  end

end
