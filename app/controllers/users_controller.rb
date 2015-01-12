# controller for user
class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = !params[:id].nil? ? User.find(params[:id]) : current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      cart = Cart.new(user: @user, total: 0)
      cart.save
      UserMailer.activation_email(@user)
      redirect_to home_path
    else
      render 'new'
      flash.now[:error] = @user.errors
    end
  end

  def resend_activation
    @user = current_user
    UserMailer.resend_activation_email(@user)
    redirect_to home_path
  end

  def activate
    @user = User.find_by_username(params[:username])
    @user.activate if @user.match_activation_token?(params[:token])
    redirect_to home_path
  end

  def activation
    @user = current_user || User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url, notice: 'User was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password,
                                 :password_confirmation, :email)
  end
end
