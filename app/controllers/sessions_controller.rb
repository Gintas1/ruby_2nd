# session controller class
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(username: params[:session][:username],
                             password: params[:session][:password])
    if user.is_a? User
      sign_in(user, params[:session][:remember])
      redirect_to home_path
    else
      flash.now[:error] = user
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to home_url
  end
end
