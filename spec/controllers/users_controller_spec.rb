require 'spec_helper'

describe UsersController do  
render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end

  describe "GET 'show'" do
    before(:each) do 
      @user = Factory(:user)
      get :show, :id => @user # rails converts @user to @user.id
    end
    it "should return http success" do      
      response.should be_success
    end
    it "should find the right user" do      
      assigns(:user).should == @user
    end
    it "should have the right title" do
      response.should have_selector(:title, :content => @user.name)
    end
    it "should include the users name" do
      response.should have_selector(:h1, :content => @user.name)
    end
    it "should have a profile image" do
      # image inside h1 tag, tests the css class gravatar of the element
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

  describe "POST 'create'" do
    describe "failure" do # tests for failed user signup      
      before(:each) do
        @attr = {:name => "", :email => "", :password => "",
                 :password_confirmation => ""}
      end
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector(:title, :content => 'Sign up')
      end
      # tries to create a new user with invalid fields
      it "should not create a new user" do
        lambda do 
          post :create, :user => @attr  # post request with invalid user attrs
        end.should_not change(User, :count)
      end
      # when fails it renders the new template
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template(:new)
      end
    end #describe failure
  end #describe POST 'create'
end
