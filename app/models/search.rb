class Search < ActiveRecord::Base
	has_many :books
	belongs_to :user_account
	serialize :groupings

	def check_for_match book
		query_params = {
			"title" => self.title,
			"department" => self.department,
			"course_number" => self.course_number,
			"author" => self.author,
			"price_min" => self.price_min,
			"price_max" => self.price_max,
			"combinator" => self.combinator,
			"groupings" => self.groupings
		}
		
		search = Book.joins(:authors, :courses, :post).ransack(query_params)
		results = search.result(:distinct=>true)
		logger.debug "Count = #{results.count}"
		results.each do |b| 
			logger.debug "Found       : #{b.id}"
		end
		logger.debug "Looking for : #{book.id}"
		if results.include? book
	        # alert user
	        logger.debug "MATCH FOUND:    \n #{book.title}"
	        user = UserAccount.find(self.user_account_id)
	        UserMailer.notify_user(user, self, book).deliver_now
	    end
	end
end