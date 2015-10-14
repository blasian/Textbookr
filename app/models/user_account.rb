class UserAccount < ActiveRecord::Base
	has_many :books, dependent: :destroy
  has_many :user_queries

	before_save { self.email = email.downcase }
  before_create :create_activation_digest
  attr_accessor :activation_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  # Returns the hash digest of the given string.
  def UserAccount.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)
  end

  def UserAccount.new_token
    SecureRandom.urlsafe_base64
  end

  def self.search(search)
    if search
      UserAccount.find_by_sql ["SELECT *
                              FROM user_accounts
                              WHERE email like :email", {:email => search}]
    end
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while UserAccount.exists?(column => self[column])
  end


  def create_activation_digest
    self.activation_token  = UserAccount.new_token
    self.activation_digest = UserAccount.digest(self.activation_token)
  end
end
