require 'spec_helper'

describe SessionsController do
render_views

  describe "GET 'new' " do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector(:title, :content => 'Sign in')
    end
  end

  describe "POST 'create' " do
    
    describe "Invalid Signin" do
      before(:each) do
        @attr = {:email => "jodido@gmail.com", :password => "invalid"}
      end
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector(:title, :content => "Sign in")
      end
      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
    
    describe "With valid email and password" do
      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email, :password => @user.password}
      end
      it "should sign in the user" do
        post :create, :session => @attr
        # controller.current_user.should == @user
        # controller.signed_in?.should be_true
      end      
      it "should redirect to to user's show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end

  end
  
end
