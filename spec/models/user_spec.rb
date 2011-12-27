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
   # @valid_attributes = {:name => 'Juan Carlos', :email => 'car@car.com'}    
  end

  # setup do
  #   @valid_attributes = {:name => 'Juan Carlos', :email => 'car@car.com'}
  # end

  # it "should create a new instance given valid attributes" do
  #   lambda {
  #     User.create(@valid_attributes)   
  #   }.should change(User, :count).by(1)
  #   # User.create!(@valid_attributes)
  # end

  it "should be invalid with an empty name" do
    @invalid_attributes = {:name => 'culo_sucio' , :email => 'otor@oroa.com'}
    a = User.new(@invalid_attributes)    
    a.save
    a.should_not be_valid
    # @this_attributes = {:name => 'uno', :email => 'otro@otro.com'}
    # @a = User.new(@this_attributes.merge(:name => ""))
    # @a.save
    # @a.valid?.should == false
  end
  
  it "should be invalid with an empty email"

  it "should reject names that are too long"

  it "should accept valid email addresses"
     
  it "should reject invalid email addresses"

  it "should reject duplicate email addresses"

end


