class SearchesController < ApplicationController
	before_action :set_query, only: [:index, :create]
	before_action :set_results, only: [:index, :create]
	PAGESIZE = 15

	def create
		if current_user_account.nil?
			flash.now[:danger] = "You must be logged in to receive alerts."
		else
			flash.now[:success] = "You will receive an email when a book matches the current query. View your currently saved queries on your account page."
			Search.create(@query)
		end
		render :action => 'index'
	end

	def destroy
		@query = Search.find(params[:id])
		@query.destroy
		flash[:success] = 'You will no longer receive alerts for this query.'
		redirect_to user_account_url(current_user_account)
	end

	private

	def set_query
		unless params[:q].nil?
			@query = {
				title: params[:q][:title_cont],
				author: params[:q][:authors_au_fname_or_authors_au_lname_cont],
				department: params[:q][:courses_department_cont],
				course_number: params[:q][:courses_course_number_eq],
				price_min: params[:q][:post_price_gteq],
				price_max: params[:q][:post_price_lteq],
				user_account_id: current_user_account.nil? ? nil : current_user_account.id,
				alert: true
			}
		end
	end

	def set_results
		if params.nil?
			@search = Book.ransack
			@search.sorts = 'created_at desc'
		else
			@search = Book.joins(:authors, :courses).ransack(params[:q])
			if params[:q].nil?
				@search.sorts = 'created_at desc'
			else
				unless params[:q][:s].nil?
					@search.sorts = params[:q][:s]
				end
			end
		end
		@results = @search.result.includes(:post, :authors, :courses).page(params[:page]).per(PAGESIZE)
	end

	# def search_params
	# 	params.require(:search).permit(:id, :title, :department, :author, :course_number, :price_min, :price_max, :user_account_id, :alert)
	# end
end