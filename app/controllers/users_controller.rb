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
    #render :nothing => true #avoids calling a non existing create.html.erb view.
    @user = User.new(params[:user])
    if @user.save # (true or false). It handles a successful save.    
      sign_in @user
      flash[:success] = "welcome to the application"
      redirect_to @user 
      # could also be: "redirect_to user_path(@user)" or
      # could also be: "redirect_to user_path(@user.id)"
    else
      # handle a save failure (describe failure testing)
      # @title = 'Sign up' 
      render :action => 'new'        
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated..."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
 
end
