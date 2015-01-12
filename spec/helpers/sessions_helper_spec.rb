require 'rails_helper'

RSpec.describe SessionsHelper, :type => :helper do
  let!(:user) {FactoryGirl.create(:user)}

  describe 'sign_in' do
    it 'checks permanent cookies if remember parameter is 1 ' do
      helper.sign_in(user, '1')
      expect(User.digest(cookies.permanent[:remember_token]))
             .to eq(User.find(user.id).token)
    end
    it 'checks cookies if remember parameter is 0' do
      helper.sign_in(user, '0')
      expect(User.digest(cookies[:remember_token]))
             .to eq(User.find(user.id).token)
    end
    it 'checks if user got new remember token' do
      user = mock('user')
      user.expects(:update_attribute)
      helper.sign_in(user, '1')
    end
  end
  describe 'signed_in?' do
    it 'returns true is user is signed in' do
      helper.sign_in(user, '0')
      expect(helper.signed_in?).to be true
    end
  end

  describe 'current_user=' do
    it 'returns user' do
      expect(helper.current_user = user).to eq(user)
    end
  end

  describe 'current_user' do
    it 'returns user if user is signed in' do
      helper.sign_in(user, '0')
      expect(helper.current_user).to eq(user)
    end
  end

  describe 'sign_out' do
    it 'current_user returns nil after user signs out' do
      helper.sign_in(user, '0')
      helper.sign_out
      expect(helper.current_user).to be nil
    end
  end
end
