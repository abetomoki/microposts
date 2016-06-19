class SessionsController < ApplicationController
  def new
  end
  
  def create
    # sessionにemailを入れる。
    @user = User.find_by(email: params[:session][:email].downcase)
    
    # もしemailとpasswordが一致すれば、session[userid]にユーザーidを入れる。
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
 
 
      
    # ユーザーページへ飛ばす。
       redirect_to @user
     else
       
       #もしもpasswordが違っていたら、newを表示。
       flash[:danger] = 'invalid email/password combination'
       render 'new'
     end
  end
  def destroy
    # ログアウト処理 session[:user_id]をnilにする。
    session[:user_id] = nil
    redirect_to root_path
  end
end