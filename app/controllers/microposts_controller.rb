class MicropostsController < ApplicationController
    # appricationcontrollerのlogged_in_userを使用。
    # もしもログインしていなければ、ログインページへ飛ばす。
    before_action :logged_in_user, only: [:create]

    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end

    def create
        # 現在のユーザに紐付いた@micropostに入れる？
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] ="Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
         end
     end

    
 private
    def micropost_params
       params.require(:micropost).permit(:content)
    end
end
