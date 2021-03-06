require 'spec_helper'

describe PagesController do
  render_views # call the views for testing, fails if the views don't exits

  before(:each) do # avoids some duplication
    @base_title = "Medical Stuff - "    
  end

  describe "GET 'home'" do # when visite home page it should be succesfull
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get :home
      # have_selector(checks the html element (title) with its correpondent content
      # (Medical Stuff..)) inside of it, it also matches a partial content.
      # si no uso assigns(:title) no puedo accecer al valor de @title del controller.
      response.should have_selector('title', :content => @base_title + "Home")
    end
  end

  describe "GET 'contact'" do # when visite contact page it should return 200 code (success)
    it "returns http success" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get :contact
      response.should have_selector('title', :content => @base_title + "Contact")
    end
  end 
  
  describe "GET 'help'" do
    it "returns http success" do
      get :help
      response.should be_success
    end      
  end 

  describe "GET 'about'" do # response of 200 code for the about request
    it "returns http success" do
      get :about
      response.should be_success
    end

    it "should have the right title" do
      get :about
      response.should have_selector('title', :content => @base_title + "About")
    end
  end  

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success    
    end

    # it "should have the right title" do
    #   get :help
    #   response.should have_selector('title', :content => @base_title  + "Help")
    # end
  end

end