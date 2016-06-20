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
      
end