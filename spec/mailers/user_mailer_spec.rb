require 'rails_helper'

RSpec.describe UserMailer, :type => :mailer do
  let(:user) do
    stub('user', username: 'name',
           email: 'example@example.com',
           activation_token: User.digest(User.new_token))
  end


  describe 'activation email' do
    it 'sends email to user' do
      expect { UserMailer.activation_email(user) }
             .to change {ActionMailer::Base.deliveries.count}.by(1)
    end
  end
  describe 'resend activation email' do
    it 'resends activation email' do
      expect { UserMailer.resend_activation_email(user) }
              .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
