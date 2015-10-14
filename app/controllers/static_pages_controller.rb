class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def suggest
  	# send email with contents of suggestion
  	flash.now[:success] = "Thank you, your suggestion has been received."
  	UserMailer.suggestion(params['bug-box'], current_user_account).deliver_now
  	render :action => 'about'
  end
end
