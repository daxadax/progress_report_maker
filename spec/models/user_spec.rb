# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {name: "user", email: "user@example.com"}
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
 
  # :NAME
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(name: ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a name between 3 and 15 characters" do
    long_name = "a" * 20
    short_name = "a" * 2
    
    wrong_namelength_user = User.new(@attr.merge(name: long_name) || User.new(@attr.merge(name: short_name)))
  end
  
  # :EMAIL
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.should_not be_valid    
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@domain.com THE_USER_123@domain.co.uk first.last@domain.com user+filter@domain.com user-x@domain.com user@domain-name.com user@1domain.com]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      valid_email_user.should be_valid
    end      
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user_at_domain.com THE USER_123(at)domain.co.uk first.last@com user@domain. user@domain,com]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      invalid_email_user.should_not be_valid
    end      
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    User.create!(@attr.merge(:email => @attr[:email].upcase))
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
end
