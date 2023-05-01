class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def ban
    
    @user =User.find(params[:id])
    
    if @user.access_locked?
      @user.unlock_access!
    else
    @user.lock_access!
    end
    redirect_to users_path, notice: "user status banned #{@user.access_locked?}"
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to users_path, notice: "The user was deleted"
  end
end
