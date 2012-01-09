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
    # post :create -> hits the create action with a http POST request
    # invalid_attr -> these are invalid form parms 
    before do
        @post_params = {:name => "fernandito", 
                       :email => "jodido@jodido.com",
                       :password => "durisimo",
                       :password_confirmation => "durisimo"}
    end      
    it "should assigns a @user variable" do 
      post :create, :user => @post_params
      # assigns(:user).should_not be_nil
      assigns(:user).nil?.should == false
      assigns(:user).should be_kind_of(User)
    end
    
    describe "failure" do # tests for failed user signup      
      before(:each) do
        @invalid_attr = {:name => "", :email => "", :password => "",
                 :password_confirmation => ""}
      end      
      # tries to create a new user with invalid fields      
      it "should not create a new user" do
        lambda do 
          post :create, :user => @invalid_attr  # post request with invalid user attrs
        end.should_not change(User, :count)
      end    
      # it "should have the right title" do
      #   post :create, :user => @invalid_attr
      #   response.should have_selector(:title, :content => 'Sign up')
      # end    
      # when creation fails it renders the already existing new template
      it "should render the 'new' page" do
        post :create, :user => @invalid_attr
        response.should render_template(:new)
      end
    end #describe failure

    describe "success" do
      before(:each) do
        @valid_attr = {:name => "valid_user", :email => "valid@email.com",
         :password => "valid_password",
         :password_confirmation => "valid_password"}             
      end
      it "should create a new user" do
        lambda do
          post :create, :user => @valid_attr
        end.should change(User, :count).by(1)
      end
      it "should redirect to the user show page" do
        post :create, :user => @valid_attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      it "should have a welcome message (flash)" do
        post :create, :user =>@valid_attr
        flash[:success].should =~ /welcome to the application/i
      end
    end #describe 'Success'

  end #describe POST 'create'
end
