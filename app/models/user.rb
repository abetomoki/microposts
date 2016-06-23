class User < ActiveRecord::Base
      before_save { self.email = self.email.downcase }
      validates :name, presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email, presence: true, length: { maximum: 255 },
                 format: { with: VALID_EMAIL_REGEX },
                 uniqueness: { case_sensitive: false }
      validates :biography, length: { maximum: 200 }
      validates :location, length: { maximum: 50 }
      has_secure_password
      has_many :microposts
      #フォローしている場合のユーザーの集まり（Realationship）を取得
      has_many :following_relationships,  class_name:   "Relationship",
                                          foreign_key:  "follower_id",
                                          dependent:    :destroy
      #フォローしている人の集まりを取得
      has_many :following_users, through: :following_relationships, source: :followed
      
      
      has_many :follower_relationships,   class_name:  "Relationship",
                                          foreign_key: "followed_id",
                                          dependent:   :destroy
      has_many :follower_users,  through: :follower_relationships, source: :follower
       
      
      def follow(other_user)
            following_relationships.find_or_create_by(followed_id: other_user.id)
      end
      
      def unfollow(other_user)
            following_relationship = following_relationships.find_by(followed_id: other_user.id)
            following_relationship.destroy if following_relationship
      end
      
      def following?(other_user)
            following_users.include?(other_user)
      end
     
      def followings_user
            following_relationships.find
            
         #参考２つ
         #1 @user = current_user.following_relationships.find(params[:id]).followed
         #2 @user = User.find(params[:id])
         #  @microposts = @user.microposts.order(created_at: :desc)
      
         #コード
          #current_userがフォローしているユーザーのidを取得。
           #current_user.followings_relationships.find(params[:id]).followed
           #following_relationship = following_relationships.find_by(followed_id: other_user.id)
           #フォローしている人の集まりを取得。
      end
  
      def following_count
            following_users.count
      end
      
      def follower_count
            follower_users.count
      end
end