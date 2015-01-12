# session helper module
module SessionsHelper
  attr_accessor :current_user
  def sign_in(user, remember)
    return if signed_in?
    token = User.new_token
    if remember == '1'
      cookies.permanent[:remember_token] = token
    else
      cookies[:remember_token] = token
    end
    user.update_attribute(:token, User.digest(token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(token: token)
  end

  def sign_out
    current_user.update_attribute(:token, User.digest(User.new_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
