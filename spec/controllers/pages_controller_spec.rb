require 'spec_helper'

describe PagesController do
  # render_views # call the views for testing

  describe "GET 'home'" do # when visite home page it should be succesfull
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'about'" do # response of 200 code for the about request
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do # when visite contact page it should return 200 code (success)
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end  

end
