class PagesController < ApplicationController
  def home # home page 
    # this instance variable @title will be available in the home.html.erb view    
    @title = 'Home'
  end

  def contact  # contact page    
    @title = 'Contact'
  end

  def about # describes the about action    
    @title = 'About'
  end

  def help
    
  end

end
