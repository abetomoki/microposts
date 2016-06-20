class MicropostsController < ApplicationController
    # appricationcontrollerのlogged_in_userを使用。
    # もしもログインしていなければ、ログインページへ飛ばす。
    before_action :logged_in_user, only: [:create]

    def create
        # 現在のユーザに紐付いた@micropostに入れる？
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] ="Micropost created!"
            redirect_to root_url
        else
            render 'static_pages/home'
         end
     end

    
 private
    def micropost_params
       params.require(:micropost).permit(:content)
    end
end
