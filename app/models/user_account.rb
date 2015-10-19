class UserAccount < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :validatable

	has_many :books, dependent: :destroy
  has_many :searches

	before_save { self.email = email.downcase }
  before_destroy :deactivate_queries

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }

  def deactivate_queries
    self.searches.each do |q|
      q.update_attribute :alert, false
    end
  end

  def self.search(search)
    if search
      UserAccount.find_by_sql ["SELECT *
                              FROM user_accounts
                              WHERE email like :email", {:email => search}]
    end
  end

end
