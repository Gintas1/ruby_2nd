# user mailer class
class UserMailer < ActionMailer::Base
  default from: 'rortestavimas@gmail.com'

  def activation_email(user)
    @user = user
    @token = @user.activation_token
    mail(to: @user.email, subject: 'Welcome to our site').deliver
  end

  def resend_activation_email(user)
    @user = user
    @token = @user.activation_token
    mail(to: @user.email, subject: 'Activation code').deliver
  end
end
