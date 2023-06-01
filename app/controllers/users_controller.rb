class UsersController < ApplicationController
  before_action :require_admin, only: [ :ban, :destroy, :resend_confirmation_instructions ]
  before_action :require_admin_or_inviter, only: [:resend_invitation]
  before_action :require_admin_or_owner, only: [:edit, :update]
  
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
    if current_user==@user
      redirect_to users_path, alert: "you can't ban yourself"
    else
      if @user.access_locked?
        @user.unlock_access!
      else
      @user.lock_access!
      end
      redirect_to users_path, notice: "user status banned #{@user.access_locked?}"
    end
  end
  
  def resend_confirmation_instructions
    @user =User.find(params[:id])
    
    if @user.confirmed? == false && @user.created_by_invite? == false
      @user.resend_confirmation_instructions
      redirect_to users_path, notice: "Resend the confirmation instructions"
    else 
      redirect_to users_path, alert: "You are already signin"
    end
  end
  
  def resend_invitation
    @user =User.find(params[:id])
    
    if @user.confirmed? == false && @user.created_by_invite? && user.invitation_accepted? == false
      @user.invite!
      redirect_to users_path, notice: "Resend invite"
    else 
      redirect_to users_path, alert: "You are already signin"
    end
  end
  
  def require_admin_or_inviter
    @user = User.find(params[:id])
    
    if current_user.admin? || current_user == @user.invited_by 
      @user.invite!
      redirect_to users_path, notice: "Resend invite"
    else 
      redirect_to users_path, alert: "You are already signin"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to users_path, notice: "The user was deleted"
  end
  
  private
  
  def user_params
    list_params_allowed = [:name] if current_user == @user || current_user.admin?
    list_params_allowed += [*User::ROLES] if current_user.admin?
    params.require(:user).permit(list_params_allowed)
  end
  def require_admin
    unless current_user.admin?
      redirect_to root_path , alert: "you are not an autherized person to perform this tasks"
    end
  end
  
  def require_admin_or_owner
    @user = User.find(params[:id])
    unless current_user==@user || current_user.admin? 
      redirect_to root_path , alert: "you are not an autherized person to perform this tasks"
    end
  end
end