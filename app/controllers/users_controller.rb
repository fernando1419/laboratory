class UsersController < ApplicationController
  def new
    @user = User.new # because this the form method in the view is post
    @title = 'Sign up'
  end

  def show  
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save # (true or false)
      # handle a successful save.
    else 
      # handle a save failure (describe failure testing)
      @title = 'Sign up' 
      render :action => 'new'
    end
  end
 
end
