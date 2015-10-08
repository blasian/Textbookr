class Search < ActiveRecord::Base
	has_many :books
	belongs_to :user_account
end