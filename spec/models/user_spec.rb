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
    a = User.new(@attr.merge(:name => ""))    
    a.valid?.should == false
    a.should have(1).errors_on(:name)    
  end

  # it "should be invalid with an empty email"

  # it "should reject names that are too long"

  # it "should accept valid email addresses"
     
  # it "should reject invalid email addresses"

  # it "should reject duplicate email addresses"

end
