class UsersController < ApplicationController
  before_action :require_admin, only: [:edit, :ban, :destroy]
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully"
    else
      render :edit
    end
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
  
  private
  
  def user_params
    params.require(:user).permit(*User::ROLES)
  end
  def require_admin
    unless current_user.admin?
      redirect_to root_path , alert: "you are not an autherized person to perform this tasks"
    end
  end
end
