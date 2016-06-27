class UsersController < ApplicationController
  before_action :session_check, only: [:edit, :update]
  
  def favorites
    @user = User.find(params[:id])
    @user_favorite = @user.favorite_microposts
  end
  
  def followings
       # @followings_user = followings_user.oreder(created_at: :desc)
      @user = User.find(params[:id])
      @user_followings = @user.following_users
  end
  
  def followers
        @user = User.find(params[:id])
        @user_followers = @user.follower_users
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    # @micropost = Micropost.find(params[:id])
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
    @micropost = Micropost.new(micropost_params)
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
