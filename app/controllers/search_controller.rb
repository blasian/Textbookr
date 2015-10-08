class SearchController < ApplicationController

	before_action :set_search

	PAGESIZE = 15

	def set_results
		@query = params[:query]
		if @query.nil? or @query == ""
			@search = Book.ransack(params[:q])
			@search.sorts = 'created_at desc'
			@results = @search.result.page(params[:page]).per(PAGESIZE)
		else
			@search = Book.ransack(params[:query])
			if (params[:q].nil?)
				@search.sorts = 'created_at desc'
			else
				@search.sorts = params[:q]['s']
			end
			@results = @search.result(:distinct=>true).page(params[:page]).per(PAGESIZE)
		end
	end

	def index
		@results = Book.ransack(params[:query])
	end

	def new

	end

	def show

	end

	def create
		@search = Search.create(search_params)
	end

	private

	def set_search
	    @user_account = Search.find(params[:id])
    end

	def search_params
		params.require(:search).permit(:title, :price_min, :price_max, :au_fname, :au_lname, :course_number, :department, :user_account_id)
	end
end