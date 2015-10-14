class SessionsController < ApplicationController
  def new
  end

  def create
  	user_account = UserAccount.find_by(email: params[:session][:email].downcase)
  	if user_account && user_account.authenticate(params[:session][:password])
      if user_account.activated?
    		log_in user_account
        flash[:success] = "Welcome back #{user_account.email}"
    		redirect_to root_url
      else
        flash.now[:danger] = "You must authenticate your account before logging in."
        render 'new'
      end  
  	else
  		flash.now[:danger] = "Invalid email/password combination."
  		render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_url	
  end
end