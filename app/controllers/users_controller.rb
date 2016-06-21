class UsersController < ApplicationController
  before_action :session_check, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "Updated your profile !!"
      redirect_to @user
    else
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'edit'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
 
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
end

  private
  
  
  def session_check
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to login_path
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                                :password_confrimation, :biography, :location)
  end
  
  
