require 'spec_helper'

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime

describe User do
  before(:each) do
    @attr = {:name => 'Juan Carlos', :email => 'car@car.com'}       
  end

  it "should create a new instance given valid attributes" do    
    lambda {
      User.create(@attr)   
    }.should change(User, :count).by(1)    
  end

  it "should be invalid with an empty name" do        
    user_without_name = User.new(@attr.merge(:name => ""))    
    user_without_name.valid?.should == false
    # user_without_name.should have(1).errors_on(:name)    
  end

  it "should be invalid with an empty email" do
    user_without_email = User.new(@attr.merge(:email => ""))
    user_without_email.valid?.should == false
    # user_without_email.should have(1).errors_on(:email)
  end

  it "should be invalid with names with more than 50 characters long" do
    long_name = 'a' * 51
    user_with_too_long_name = User.new(@attr.merge(:name => long_name))
    user_with_too_long_name.valid?.should == false
  end

  it "should be invalid with names with less than 5 characters long" do
    short_name = 'a' * 4
    user_with_too_short_name = User.new(@attr.merge(:name => short_name))
    user_with_too_short_name.valid?.should == false
  end

  it "should accept valid email addresses" do
    valid_emails = %w[user@email.com user.surname@gmail.com user_1@gmail.com.ar]
    valid_emails.each do |email|
      valid_email_user = User.new(@attr.merge(:email => email))
      valid_email_user.valid?.should == true
    end
  end
     
  it "should reject invalid email addresses" do
    invalid_emails = %w[user#email.com user.surname@.com user,1@gmail.com.ar]
    invalid_emails.each do |email|
      invalid_email_user = User.new(@attr.merge(:email => email))
      invalid_email_user.valid?.should == false
    end
  end

  ## Uniqueness Validation
  it "should reject duplicate email addresses" do
    # records a user with given email address into the DB.
    User.create!(@attr) # one user with an email address
    user_with_duplicate_email = User.new(@attr) # another user with same email 
    user_with_duplicate_email.valid?.should == false
  end

end
