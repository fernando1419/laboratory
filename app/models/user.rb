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
  # validates :name, :presence => true  # validates presence of name attribute
end