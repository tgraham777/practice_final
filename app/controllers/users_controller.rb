class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.name}!"
      redirect_to user_path(user.id)
    else
      flash[:errors] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
