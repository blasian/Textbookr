class SearchesController < ApplicationController
	before_action :set_search
	PAGESIZE = 15

	def search
		create unless params[:q].nil?
		render :action => 'index'
	end

	def create
		@query = Search.create(
			title: params[:q]["title_cont"], 
			author: params[:q]["authors_au_fname_or_authors_au_lname_cont"], 
			course: params[:q]["courses_department_cont"],
			price_min: params[:q]["post_price_gteq"], 
			price_max: params[:q]["post_price_lteq"], 
			user_account_id: current_user_account.nil? ? nil : current_user_account.id,
			groupings: params[:groupings],
			combinator: params[:combinator])
		@query.save
	end

	def update
		@query = Search.find(params[:id])
		if @query.update_attributes(search_params)
			# flash[:success] = "Success."
			# UserMailer.initialize_tracking(user, self, book).deliver_now
		end
		render :action => 'index'
	end

	private

	def set_search
		@query = @query || {}

		if params[:q].nil?
			@search = Book.ransack(params[:q])
			@search.sorts = 'created_at desc'
		else
			params[:combinator] = 'and'
			params[:groupings] = []
			params[:q].each_pair do |key, value|
				unless key == 's'
					custom_words = value
					custom_words.split(' ').each do |word|
						params[:groupings] << {key => word}
					end
				end
			end
			@search = Book.joins(:authors, :courses).ransack(params)
			if params[:q][:s].nil?
				@search.sorts = 'created_at desc'
			else
				@search.sorts = params[:q][:s]
			end
		end
		@results = @search.result(:distinct=>true).includes(:post, :authors, :courses).page(params[:page]).per(PAGESIZE)
	end

	def search_params
		params.require(:search).permit(:id, :title, :author, :course, :price_min, :price_max, :user_account_id, :alert)
	end
end