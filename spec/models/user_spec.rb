# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => 'Juan Carlos',
      :email => 'car@car.com',
      :password => 'jodido',
      :password_confirmation => 'jodido'
    }       
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

  describe  "Passwords" do
    
    describe "Existence" do       
      before(:each) do
        @user = User.create!(@attr)
      end
      it "should have a password attribute" do
        @user.should respond_to(:password)
      end
      it "should have a password_confirmation attribute" do
        @user.should respond_to(:password_confirmation)
      end      
    end

    describe "Validations" do                  
      it "should fail with empty passwords" do
        a = User.new(@attr.merge(:password => "", :password_confirmation => ""))
        a.valid?.should == false
      end
      it "should fail with a non matching password_confirmation" do
        a = User.new (@attr.merge(:password_confirmation => "not_matching_string"))
        a.valid?.should == false
      end
      it "should reject passwords with less than 5 chars" do
        short_pass = %w[5555 3 aaaa rrrrr]      
        short_pass.each do |pass|
          hash_with_short_passwords = @attr.merge(:password => pass, 
          :password_confirmation => pass)
          a = User.new(hash_with_short_passwords)
          a.valid?.should == false        
        end      
      end
      it "should reject passwords with more than 40 chars" do
        long_pass = "b" * 41      
        hash_with_long_passwords = @attr.merge(:password => long_pass, 
        :password_confirmation => long_pass)
        a = User.new(hash_with_long_passwords)
        a.valid?.should == false
      end
    end

    describe "Encryption" do 
      before(:each) do
        @user = User.create!(@attr)
      end      
      it "should have an encrypted password attribute" do 
        #respond_to?, accepts a symbol and returns true if the object
        # responds to the given method or attribute and false otherwise
        @user.should respond_to(:encrypted_password)
      end
      it "should have a non blank encrypted password" do
        # should set the encrypted password      
        @user.encrypted_password.blank?.should == false
      end    
      
      describe "has_password? method" do
        it "should have a has_password? method" do
          @user.respond_to?(:has_password?).should == true
        end
        it "should return true if the passwords match" do
          @user.has_password?(@attr[:password]).should == true
        end
        it "should return false if the passwords do not match" do
          @user.has_password?('invalid').should == false
        end
      end #describe has_password? method

      describe "authenticate method" do
        it "should have an authenticate method" do
          User.should respond_to(:authenticate) # class method
        end
        it "should return nil on email/password mismatch" do
          User.authenticate(@attr[:email], "wrongpassword").should be_nil
        end
        it "should return nil for an email with no matching user" do
          User.authenticate("noexiste@email.com", @attr[:password]).should be_nil
        end
        it "should return the user on email/password match" do
          User.authenticate(@attr[:email], @attr[:password]).should == @user
        end        
      end #describe authenticate method
      
    end # describe encryption

  end # describe Passwords

end # describe User
