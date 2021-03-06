class User < ActiveRecord::Base

	before_save { self.email = email.downcase }		#converted to lowercase before saving
  before_create :create_remember_token

	validates :name,  presence: true, length: { maximum: 50 }
  		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	#validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    has_secure_password		# for password
    validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    #admin
    has_many :tracks, dependent: :destroy
    has_many :albums, dependent: :destroy

    def feed
      # Это предварительное решение. См. полную реализацию в "Following users".
      Track.where("user_id = ?", id)
  end
end
