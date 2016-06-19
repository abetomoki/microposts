module SessionsHelper
    #ログイン時はそのユーザーを返し、そうでなければnilを返す
    def current_user 
        # ||はorの意味。falseかnilであればインスタンス変数に代入
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !!current_user
    end
    
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end
