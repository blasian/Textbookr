class UserQuery < ActiveRecord::Base
	belongs_to :user_account

	def check_for_match book
		query_params = {
			"title_or_authors_au_fname_or_authors_au_lname_or_courses_department_cont_any" => self.query_str,
			"combinator" => "or",
			"groupings" => []
		}
		return if self.query_str.nil?
		self.query_str.split(' ').each_with_index do |word, index|
			query_params['groupings'][index] = {title_or_authors_au_fname_or_authors_au_lname_or_courses_department_cont: word}
	    end
		@search = Book.joins(:authors, :courses).ransack(query_params)
		@results = @search.result(:distinct=>true)
		logger.debug "Count = #{@results.count}"
		@results.each do |b| 
			logger.debug "Found       : #{b.id}"
		end
		logger.debug "Looking for : #{book.id}"
		if @results.include? book
	        # alert user
	        logger.debug "MATCH FOUND:    \n #{self.query_str} \n #{book.title}"
	        user = UserAccount.find(self.user_account_id)
	        UserMailer.notify_user(user, self, book).deliver_now
	    end
	end
end