class SessionsController < ApplicationController
  def new
    @title = 'Sign in'
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      # show invalid message and re-render sign up form.
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      # sign the user in and redirect user's show page
      sign_in user
      redirect_to user
    end    
  end

  def destroy
    
  end

end
