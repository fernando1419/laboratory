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
    User.create!(@attr)   
  end

  it "should require a name" do
    #{:name=>'',:email=>'car@car.com'}
    user_with_empty_name = User.new(@attr.merge(:name => ""))    
    user_with_empty_name.valid?.should == false 
    # more correct rspec sintaxis ->  invalid_user.should_not be_valid
  end

end


