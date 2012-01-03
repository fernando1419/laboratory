class User < ActiveRecord::Base

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
  attr_accessible :name, :email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :name, :presence => true, 
                   :length => {:minimum => 5, :maximum => 50}
  validates :email, :presence => true, 
                    :format => { :with => email_regex },
                    :uniqueness => true
end